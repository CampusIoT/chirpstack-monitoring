#!/bin/bash

#TODAY="2021-03-02"
TODAY="$(date +"%Y-%m-%d")"

#On stock les ids des gateways d'aujourd'hui
ids=$(jq --raw-output ".result[] | .id" .gateways.json)
id=()
i=0
for ID in $ids
do
    id[$i]=$ID
    i=$((i+1))
done

#On stock les dates de dernière activité des gateways d'aujourd'hui
dates=$(jq --raw-output ".result[] | .lastSeenAt" .gateways.json)
date=()
date=($dates)
state=()
full_date==()
d=()
for (( i=0; i<${#date[@]}; i++ ))
do
    if [[ ${date[$i]} == "null" ]]
    then
        full_date[$i]=${date[$i]}
        d[$i]=${full_date[$i]}
    else
        full_date[$i]=$(echo $date[$i] | tr "T" "\n")
        for arg in $full_date[$i]
        do
            d[$i]=$arg
            break
        done
    fi
done


#On stock les states des gateways d'aujourd'hui dans un tableau en regardant la date
#de dernière activité des gateways
for (( i=0; i<${#d[@]}; i++ ))
do
    if [[ "${d[$i]}" == "$TODAY" ]]
    then
        state[$i]="active"
    else
        state[$i]="passive"
    fi
done

#On stock les ids des gateways d'hier
ids_2=$(jq --raw-output ".result[] | .id" lastGatewaysStates.json)
id_2=()
i=0
for ID in $ids_2
do
    id_2[$i]=$ID
    i=$((i+1))
done

#On stock les states des gateways d'hier
full_state=$(jq --raw-output ".result[] | .lastState" lastGatewaysStates.json)
states_2=()
j=0
for s in $full_state
do
    state_2[$j]=$s
    j=$((j+1))
done


#On compare les states des gateways d'aujourd'hui et hier
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
                    replacement="<li style="color:green"><a href='https://lns.campusiot.imag.fr/#/organizations/6/gateways/7276ff0039030716'>7276ff0039030716</a>: KER_FEMTO_030716_P307 - (org 6) - 2021-03-07T19:14:43.804084Z</li>"
                else
                    replacement="<li style="color:red"><a href='https://lns.campusiot.imag.fr/#/organizations/6/gateways/7276ff0039030716'>7276ff0039030716</a>: KER_FEMTO_030716_P307 - (org 6) - 2021-03-07T19:14:43.804084Z</li>"
                fi
                sed -i "/${id[$i]}/c $replacement" .gateways.html
            fi
        fi
    done
done

#On met à jour les states des gateways pour le prochain jour
echo "{
  \"totalCount\": \"${#id[@]}\",
  \"result\": [" > lastGatewaysStates.json

for (( i=0; i<$((${#id[@]}-1)); i++ ))
do
    echo "    {
      \"id\": \"${id[$i]}\",
      \"lastState\": \"${state[$i]}\"
    }," >> lastGatewaysStates.json
done

echo "    {
      \"id\": \"${id[$((${#id[@]}-1))]}\",
      \"lastState\": \"${state[$((${#id[@]}-1))]}\"
    }
  ]
}" >> lastGatewaysStates.json







#jq --raw-output -f gateways_to_html.jq .gateways.json | grep "0000024b0805031a"




#jq --raw-output ".result" .gateways.json
#jq -c ".result | sort_by(.lastSeenAt, .id) | reverse []" .gateways.json
#data=()
#objects=()
#id=()
#lastSeenAt=()
#i=0
#while read x
#do
#    data[$i]=$(echo $x | tr "," "\n")
#    i=$((i+1))
#done <data.txt
#
#echo ${data[1]}
#echo "---"
#j=0
#cpt=$((${#data[@]}-1))
#for (( j=0; j<=$cpt; j++ ))
#do
#    echo ${data[$j]}
#    echo "---"
#
#    #On récupère toutes les id dans le tableau id
#    tmp=$(echo ${data[$j]} | tr [:space:] "_" | sed -e 's,"id":,\n,g')
#    k=0
#    for d in $tmp
#    do
#        objects[$k]=$d
#        k=$((k+1))
#    done
#    tmp=$(echo ${objects[1]} | tr "_" "\n")
#    for a in $tmp
#    do
#        id[$j]=$a
#        break
#    done
#
#    #On récupère toutes les dates lastSeenAt dans un tableau (qui représentera le champ pour chaque id)
#    #tmp
#done
#
#echo ${id[0]}
#echo ${id[1]}
#echo ${id[2]}
#echo ${id[3]}
##echo $test
##echo ${objects[1]}