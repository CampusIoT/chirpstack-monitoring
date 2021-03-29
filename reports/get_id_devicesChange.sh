#!/bin/bash

TODAY="$(date +"%Y-%m-%d")"

#On stock les ids des devices d'aujourd'hui
ids=$(jq --raw-output ".result[] | select(.!=null) | .devEUI" .devices.json)
id=($ids)


#On stock les dates de dernière activité des devices d'aujourd'hui
dates=$(jq --raw-output ".result[] | select(.!=null) | .lastSeenAt" .devices.json)
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

#On stock les states des devices d'aujourd'hui dans un tableau en regardant la date
#de dernière activité des devices
for (( i=0; i<${#d[@]}; i++ ))
do
    if [[ "${d[$i]}" == "$TODAY" ]]
    then
        state[$i]="active"
    else
        state[$i]="passive"
    fi
done


#On stock les ids des devices d'hier
ids_2=$(jq --raw-output ".result[] | .id" lastdevicesStates.json)
id_2=()
i=0
for ID in $ids_2
do
    id_2[$i]=$ID
    i=$((i+1))
done

#On stock les states des devices d'hier
full_state=$(jq --raw-output ".result[] | .lastState" lastdevicesStates.json)
states_2=()
j=0
for s in $full_state
do
    state_2[$j]=$s
    j=$((j+1))
done


#On compare les states des devices d'aujourd'hui et hier
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
                    tmp=$(grep ${id[$i]} < .devices.html)
                    replacement=${tmp/"<li>"/"<li style="color:green">"}
                else
                    tmp=$(grep ${id[$i]} < .devices.html)
                    replacement=${tmp/"<li>"/"<li style="color:red">"}
                fi
                sed -i "/${id[$i]}/c $replacement" .devices.html
            fi
        fi
    done
    if [[ ${date[$i]} != "null" ]]
    then
        tmp=$(grep ${id[$i]} < .devices.html)
        dateFromNow=$(node changeDateMomentjs.js ${date[$i]})
        replacement=${tmp/${date[$i]}/"$dateFromNow"}
        sed -i "/${id[$i]}/c $replacement" .devices.html
    fi
done

#On met à jour les states des devices pour le prochain jour
echo "{
  \"totalCount\": \"${#id[@]}\",
  \"result\": [" > lastdevicesStates.json

for (( i=0; i<$((${#id[@]}-1)); i++ ))
do
    echo "    {
      \"id\": \"${id[$i]}\",
      \"lastState\": \"${state[$i]}\"
    }," >> lastdevicesStates.json
done

echo "    {
      \"id\": \"${id[$((${#id[@]}-1))]}\",
      \"lastState\": \"${state[$((${#id[@]}-1))]}\"
    }
  ]
}" >> lastdevicesStates.json