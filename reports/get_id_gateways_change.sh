#!/bin/bash

TODAY="$(date +"%Y-%m-%d")"

# DATA REPOSITORY
DATA_GAT_FOLDER="data/gateways/"

#We store gateways' ids of the present day
ids=$(jq --raw-output ".result[] | .id" ${DATA_GAT_FOLDER}.gateways.json)
id=($ids)


#We store dates from the last activity of the gateways from today
dates=$(jq --raw-output ".result[] | .lastSeenAt" ${DATA_GAT_FOLDER}.gateways.json)
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


#We store states from today gateways in an array by looking at last activity dates
for (( i=0; i<${#d[@]}; i++ ))
do
    if [[ "${d[$i]}" == "$TODAY" ]]
    then
        state[$i]="active"
    else
        state[$i]="passive"
    fi
done

#We store yesterday gateways ids
ids_2=$(jq --raw-output ".result[] | .id" ${DATA_GAT_FOLDER}.last_gateways_states.json)
id_2=()
i=0
for ID in $ids_2
do
    id_2[$i]=$ID
    i=$((i+1))
done

#We store yesterday gateways states
full_state=$(jq --raw-output ".result[] | .lastState" ${DATA_GAT_FOLDER}.last_gateways_states.json)
states_2=()
j=0
for s in $full_state
do
    state_2[$j]=$s
    j=$((j+1))
done


#We compare today and yesterday gateways states
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
                    tmp=$(grep ${id[$i]} < .gateways.html)
                    replacement=${tmp/"<li>"/"<li style="color:green">"}
                else
                    tmp=$(grep ${id[$i]} < .gateways.html)
                    replacement=${tmp/"<li>"/"<li style="color:red">"}
                fi
                sed -i "/${id[$i]}/c $replacement" .gateways.html
            fi
        fi
    done
    if [[ ${date[$i]} != "null" ]]
    then
        tmp=$(grep ${id[$i]} < .gateways.html)
        dateFromNow=$(node change_date_momentjs.js ${date[$i]})
        replacement=${tmp/${date[$i]}/"$dateFromNow"}
        sed -i "/${id[$i]}/c $replacement" .gateways.html
    fi
done

#We update gateways state for the next day
echo "{
  \"totalCount\": \"${#id[@]}\",
  \"result\": [" > ${DATA_GAT_FOLDER}.last_gateways_states.json

for (( i=0; i<$((${#id[@]}-1)); i++ ))
do
    echo "    {
      \"id\": \"${id[$i]}\",
      \"lastState\": \"${state[$i]}\"
    }," >> ${DATA_GAT_FOLDER}.last_gateways_states.json
done

echo "    {
      \"id\": \"${id[$((${#id[@]}-1))]}\",
      \"lastState\": \"${state[$((${#id[@]}-1))]}\"
    }
  ]
}" >> ${DATA_GAT_FOLDER}.last_gateways_states.json