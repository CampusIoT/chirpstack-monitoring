#!/bin/bash

TODAY="2021-03-02"

ids=$(jq --raw-output ".result[] | .id" test_json1.json)
id=()
i=0
for ID in $ids
do
    id[$i]=$ID
    i=$((i+1))
done
dates=$(jq --raw-output ".result[] | .lastSeenAt" test_json1.json)
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


for (( i=0; i<${#d[@]}; i++ ))
do
    if [[ "${d[$i]}" == "$TODAY" ]]
    then
        state[$i]="active"
    else
        state[$i]="passive"
    fi
done



ids_2=$(jq --raw-output ".result[] | .id" test_json2.json)
id_2=()
i=0
for ID in $ids_2
do
    id_2[$i]=$ID
    i=$((i+1))
done

full_state=$(jq --raw-output ".result[] | .lastState" test_json2.json)
states_2=()
j=0
for s in $full_state
do
    state_2[$j]=$s
    j=$((j+1))
done

for (( i=0; i<${#id[@]}; i++ ))
do
    for (( j=0; j<${#id_2[@]}; j++ ))
    do
        if [[ "$id[$i]" == "$id_2[$j]" ]]
        then
            if [[ "${state[$i]}" != "${state_2[$j]}" ]]
            then
                echo ${id[$i]}+"CHANGEMENT"
            fi
        fi
    done
done

#jq --raw-output -f gateways_to_html.jq test_json1.json | grep "0000024b0805031a"




#jq --raw-output ".result" test_json1.json
#jq -c ".result | sort_by(.lastSeenAt, .id) | reverse []" test_json1.json
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