#!/bin/bash

# -------------------------------------------------
# Description:  Get the detail of a gateway 
# List Command: x
# Usage:        runned by get_gateways.sh
# Create by:    CampusIoT Dev Team, 2016-2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# # Milestone: Version 2021
# -------------------------------------------------

# Parameters
if [[ $# -ne 2 ]] ; then
    echo "Usage: $0 JWT GWID"
    exit 1
fi

TOKEN="$1"
GWID="$2"

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
DATA_GAT_FOLDER="data/gateways/"

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

${GET} \
  --header "$AUTH" ${URL}'/api/gateways/'${GWID} \
  > ${DATA_GAT_FOLDER}.gateway-${GWID}.json
