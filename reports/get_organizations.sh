#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# -------------------------------------------------
# Description:  Get organizations 
# List Command: x
# Usage:        runned by generate_reports.sh
# Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# Milestone: Version 2021
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
DATA_ORG_FOLDER="data/organizations/"

# Operations
#CURL="curl --verbose"
CURL="curl --insecure"
#CURL="curl -s"
GET="${CURL} -X GET --header \""$ACCEPT_JSON"\""
POST="${CURL} -X POST --header \""$ACCEPT_JSON"\""
PUT="${CURL} -X PUT --header \""$ACCEPT_JSON"\""
DELETE="${CURL} -X DELETE --header \""$ACCEPT_JSON"\""
OPTIONS="${CURL} -X OPTIONS --header \""$ACCEPT_JSON"\""
HEAD="${CURL} -X HEAD --header \""$ACCEPT_JSON"\""

${GET} \
  --header "$AUTH" ${URL}'/api/organizations?limit=1000&offset=0' \
  > ${DATA_ORG_FOLDER}.organizations.json


jq '.result[] | ( .id + ": " + .name + " - " + .displayName)' ${DATA_ORG_FOLDER}.organizations.json

ids=$(jq --raw-output ".result[] | .id" ${DATA_ORG_FOLDER}.organizations.json)
ids_array=($ids)

for (( i=0; i<${#ids_array[@]}; i++ ))
do
  ./get_applications.sh $TOKEN "${ids_array[i]}"
done
