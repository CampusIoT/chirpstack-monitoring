#!/bin/bash

# -------------------------------------------------
# Description:  Get gateways 
# List Command: x
# Usage:        runned by generate_reports.sh
# Create by:    CampusIoT Dev Team, 20162021 - Copyright (C) CampusIoT,  - All Rights Reserved
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
  --header "$AUTH" ${URL}'/api/gateways?limit=1000&offset=0' \
  > ${DATA_GAT_FOLDER}.gateways.json

TODAY=$(date +"%Y-%m-%d")

#generates json files of gateways informations and gateways statistics.
GATEWAYS=$(jq --raw-output ".result | sort_by(.lastSeenAt, .id) | reverse [] | (.id)" ${DATA_GAT_FOLDER}.gateways.json)
GATEWAYS_LEN=$(jq --raw-output ".totalCount" ${DATA_GAT_FOLDER}.gateways.json)
for g in $GATEWAYS
do
echo "get details for gateway $g (basic & stats informations)"
./get_gateway.sh $TOKEN $g
./get_gateway_stats.sh $TOKEN $g $TODAY
done

echo "generate html (2 copies : one with sparkline and one without sparkline)"
./generate_gateways_report.sh $GATEWAYS_LEN $GATEWAYS $TODAY

echo "comparing gateways states Passives and Actives of the report with the last report."
echo -e "\t in green : gateways who was passive became active"
echo -e "\t in red : gateways who was active became passive"
./get_id_gateways_change.sh ".gateways.html"
./get_id_gateways_change.sh ".gateways_without_sparkline.html"

# Installation
if ! [ -x "$(command -v phantomjs)" ]; then
  echo 'phantomjs is not installed. Installing phantomjs ...'
  sudo apt-get install -y phantomjs
fi

package='graceful-fs'
if [ `npm list --silent | grep -c $package` -eq 0 ]; then
    echo 'graceful-fs is not installed. Installing graceful-fs ...'
    npm install "webshot"
    npm install $package
fi

# Generate an image of the page html with sparkline
echo "Generate an image of the page html with sparkline"
node generate_sparkline_image.js
