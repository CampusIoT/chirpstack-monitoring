#!/bin/bash

# -------------------------------------------------
# Description:  search for changement of devices state and update HTML 
# List Command: x
# Usage:        runned by get_devices.sh
# Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# Milestone: Version 2021
# -------------------------------------------------

# Installation
package='moment'
if [ `npm list | grep -c $package` -eq 0 ]; then
    echo 'momentjs is not installed. Installing momentjs ...'
    npm install $package
fi

TODAY="$(date +"%Y-%m-%d")"

# DATA REPOSITORY
DATA_DEV_FOLDER="data/devices/"
DATA_HTML_FOLDER="data/generated_files/"
devices_html="${DATA_HTML_FOLDER}.devices.html"

#We store devices' ids of the present day
ids=$(jq --raw-output ".result[] | select(.!=null) | .devEUI" ${DATA_DEV_FOLDER}.devices.json)
id=($ids)


#We store dates from the last activity of the devices from today
dates=$(jq --raw-output ".result[] | select(.!=null) | .lastSeenAt" ${DATA_DEV_FOLDER}.devices.json)
date=()
date=($dates)
state=()
full_date=()
d=()
for (( i=0; i<${#date[@]}; i++ ))
do
    if [[ ${date[$i]} == "null" ]]
    then
        full_date[$i]=${date[$i]}
        d[$i]=${full_date[$i]}
    else
        full_date[$i]=$(echo ${date[$i]} | tr "T" "\n")
        for arg in ${full_date[$i]}
        do
            d[$i]=$arg
            break
        done
    fi
done

#We store states from today devices in an array by looking at last activity dates
for (( i=0; i<${#d[@]}; i++ ))
do
    if [[ "${d[$i]}" == "$TODAY" ]]
    then
        state[$i]="active"
    else
        state[$i]="passive"
    fi
done


if [ -f "${DATA_DEV_FOLDER}.last_devices_states.json" ]; then
    #We store yesterday devices ids
    ids_2=$(jq --raw-output ".result[] | .id" ${DATA_DEV_FOLDER}.last_devices_states.json)
    id_2=()
    i=0
    for ID in $ids_2
    do
        id_2[$i]=$ID
        i=$((i+1))
    done

    #We store yesterday devices states
    full_state=$(jq --raw-output ".result[] | .lastState" ${DATA_DEV_FOLDER}.last_devices_states.json)
    states_2=()
    j=0
    for s in $full_state
    do
        state_2[$j]=$s
        j=$((j+1))
    done
fi

#We compare today and yesterday devices states
for (( i=0; i<${#id[@]}; i++ ))
do
    for (( j=0; j<${#id_2[@]}; j++ ))
    do
        if [[ "$id[$i]" == "$id_2[$j]" ]]
        then
            if [[ "${state[$i]}" != "${state_2[$j]}" ]]
            then
                if [[ "${state[$i]}" == "active" ]]
                then
                    tmp=$(grep ${id[$i]} < ${devices_html})
                    replacement=${tmp/"<li>"/"<li style="color:green">"}
                else
                    tmp=$(grep ${id[$i]} < ${devices_html})
                    replacement=${tmp/"<li>"/"<li style="color:red">"}
                fi
                sed -i "/${id[$i]}/c $replacement" ${devices_html}
            fi
        fi
    done
    if [[ ${date[$i]} != "null" ]]
    then
        tmp=$(grep ${id[$i]} < "${devices_html}")
        dateFromNow=$(node change_date_momentjs.js ${date[$i]})
        replacement=${tmp/${date[$i]}/"$dateFromNow"}
        sed -i "/${id[$i]}/c $replacement" ${devices_html}
    fi
done

#We update devices state for the next day
echo "{
  \"totalCount\": \"${#id[@]}\",
  \"result\": [" > ${DATA_DEV_FOLDER}.last_devices_states.json

for (( i=0; i<$((${#id[@]}-1)); i++ ))
do
    echo "    {
      \"id\": \"${id[$i]}\",
      \"lastState\": \"${state[$i]}\"
    }," >> ${DATA_DEV_FOLDER}.last_devices_states.json
done

echo "    {
      \"id\": \"${id[$((${#id[@]}-1))]}\",
      \"lastState\": \"${state[$((${#id[@]}-1))]}\"
    }
  ]
}" >> ${DATA_DEV_FOLDER}.last_devices_states.json