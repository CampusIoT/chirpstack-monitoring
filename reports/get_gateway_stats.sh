#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# ------------------------------------------------
# Get the stats of a get gateway
# ------------------------------------------------

# Parameters
if [[ $# -ne 3 ]] ; then
    echo "Usage: $0 JWT GWID TODAY"
    exit 1
fi

TOKEN="$1"
GWID="$2"
TODAY="$3"

AUTH="Grpc-Metadata-Authorization: Bearer $TOKEN"

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

PAST_MONTH=$(date -d "-1 month" +%Y-%m-%d)
INTERVAL="day"

${GET} \
  --header "$AUTH" ${URL}'/api/gateways/'${GWID}'/stats?interval='${INTERVAL}'&startTimestamp='${PAST_MONTH}'T00:00:00Z&endTimestamp='${TODAY}'T00:00:00Z' \
  > ${DATA_GAT_FOLDER}.gateway-${GWID}_stats.json

#  'https://lns.campusiot.imag.fr/api/gateways/7276ff0039030724/stats?interval=day&startTimestamp=2021-02-09T00%3A00%3A00Z&endTimestamp=2021-03-09T00%3A00%3A00Z'
 
#   https://lns.campusiot.imag.fr:443'/api/gateways/'7276ff0039030871'/stats?interval='day'&startTimestamp=$'2021-02-09'T00:00:00Z&endTimestamp='2021-03-09'T00:00:00Z'