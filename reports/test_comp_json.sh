TODAY=$(date +"%Y-%m-%d")
#jq --raw-output -f gateways_to_html.jq .gateways.json | grep $TODAY


json1=$(jq -c ".result | sort_by(.lastSeenAt, .id) | reverse []" test_json1.json)
#json2=$(jq --raw-output ".result | sort_by(.lastSeenAt, .id) | reverse [] | (.id)" test_json2.json)
d1=$(jq --raw-output ".result | sort_by(.lastSeenAt, .id) | reverse [] | (.lastSeenAt)" test_json1.json)
#echo $json1
jq -c ".result | sort_by(.lastSeenAt, .id) | reverse []" test_json1.json | while read i; do
echo $i
echo "---"
#done
#for j1 in $json1
#do
#echo $j1
#echo "---"
#id=
#d1=$(jq --raw-output ".result | sort_by(.lastSeenAt, .id) | reverse [] | (.lastSeenAt)" test_json1.json |)
#echo $d1
done