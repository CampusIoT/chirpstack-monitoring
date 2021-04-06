#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# -------------------------------------------------
# Description:  Get devices
# List Command: x
# Usage:        runned by generate_reports.sh
# Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# Version:      1.0
# -------------------------------------------------
# Bug:
# -------------------------------------------------

# Parameters
if [[ $# -ne 1 ]] ; then
    echo "Usage: $0 JWT"
    exit 1
fi

TOKEN="$1"

AUTH="Grpc-Metadata-Authorization: Bearer $TOKEN"
#sudo npm install -g jwt-cli
#jwt $TOKEN

# Installation
if ! [ -x "$(command -v jq)" ]; then
  echo 'jq is not installed. Installing jq ...'
  sudo apt-get install -y jq
fi

if ! [ -x "$(command -v curl)" ]; then
  echo 'curl is not installed. Installing curl ...'
  sudo apt-get install -y curl
fi

# Content-Type
ACCEPT_JSON="Accept: application/json"
ACCEPT_CSV="Accept: text/csv"
CONTENT_JSON="Content-Type: application/json"
CONTENT_CSV="Content-Type: text/csv"

# LOCAL
#PORT=8888
#URL=http://localhost:$PORT

# PROD
PORT=443
URL=https://lns.campusiot.imag.fr:$PORT

# DATA REPOSITORY
DATA_APP_FOLDER="data/applications/"
DATA_ORG_FOLDER="data/organizations/"
DATA_DEV_FOLDER="data/devices/"

# Operations
# Operations
#CURL="curl --verbose"
CURL="curl -s --insecure"
#CURL="curl -s"
GET="${CURL} -X GET --header \""$ACCEPT_JSON"\""
POST="${CURL} -X POST --header \""$ACCEPT_JSON"\""
PUT="${CURL} -X PUT --header \""$ACCEPT_JSON"\""
DELETE="${CURL} -X DELETE --header \""$ACCEPT_JSON"\""
OPTIONS="${CURL} -X OPTIONS --header \""$ACCEPT_JSON"\""
HEAD="${CURL} -X HEAD --header \""$ACCEPT_JSON"\""


ids_org=$(jq --raw-output ".result[] | .id" ${DATA_ORG_FOLDER}.organizations.json)
ids_org_array=($ids_org)
nb_devices=0
DID=() #List of Devices' IDs
OID=() #List of Organisations' IDs linked to the DID (ex OID[0] is the orgID of DID[0])
for ((i=0; i<${#ids_org_array[@]}; i++))
do
  ids_app=$(jq --raw-output ".result[] | .id" ${DATA_APP_FOLDER}.organization${ids_org_array[i]}_applications.json)
  ids_app_array=($ids_app)
  for ((j=0; j<${#ids_app_array[@]}; j++))
  do
    DID[$nb_devices]=${ids_app_array[$j]}
    OID[$nb_devices]=${ids_org_array[$i]}
    nb_devices=$((nb_devices+1))
    ${GET} \
      --header "$AUTH" ${URL}'/api/devices?limit=9999&applicationID='${ids_app_array[j]} \
      > ${DATA_DEV_FOLDER}.application${ids_app_array[j]}_devices.json
  done
done

jq -s '.[0].result = [.[].result | add] | .[0]' ${DATA_DEV_FOLDER}.application*.json > ${DATA_DEV_FOLDER}.devices.json

ids=$(jq --raw-output ".result[] | select(.!=null) | .devEUI" ${DATA_DEV_FOLDER}.devices.json)
id=($ids)

tmp=$(grep "totalCount" < ${DATA_DEV_FOLDER}.devices.json)
replacement=${tmp/"1"/"${#id[@]}"}
sed -i "/"totalCount"/c $replacement" ${DATA_DEV_FOLDER}.devices.json


#${GET} \
#  --header "$AUTH" ${URL}'/api/devices?limit=9999&offset=0' \
#  > .devices.json



echo '<html><head><title>CampusIoT LNS :: Devices</title></head><body style="font-family:verdana;"><h1>CampusIoT LNS :: Devices</h1>' > .devices.html

TODAY=$(date +"%Y-%m-%d")
echo '<p>generated at ' >> .devices.html
date +"%Y-%m-%d %T %Z" >> .devices.html
echo ' - ' >> .devices.html
TZ=GMT date +"%Y-%m-%d %T %Z" >> .devices.html
echo '</p>' >> .devices.html

echo '<h2>Active devices</h2>' >> .devices.html

jq --raw-output -f devices_to_html.jq ${DATA_DEV_FOLDER}.devices.json | grep $TODAY >> .devices.html

echo '<h2>Passive devices</h2>' >> .devices.html

jq --raw-output -f devices_to_html.jq ${DATA_DEV_FOLDER}.devices.json | grep -v $TODAY >> .devices.html

echo '</body></html>' >> .devices.html

./get_id_devices_change.sh


for ((i=0; i<${#DID[@]}; i++))
do
  ./change_url_orgaID.sh ${DID[$i]} ${OID[$i]}
done
