#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# ------------------------------------------------
# Get getaways
# ------------------------------------------------

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
  > .gateways.json

echo '<html><head><title>CampusIoT LNS :: Gateways</title></head><body style="font-family:verdana;"><h1>CampusIoT LNS :: Gateways</h1>' > .gateways.html

TODAY=$(date +"%Y-%m-%d")
echo '<p>generated at ' >> .gateways.html
date +"%Y-%m-%d %T %Z" >> .gateways.html
echo ' - ' >> .gateways.html
TZ=GMT date +"%Y-%m-%d %T %Z" >> .gateways.html
echo '</p>' >> .gateways.html

echo '<h2>Active gateways</h2>' >> .gateways.html

jq --raw-output -f gateways_to_html.jq .gateways.json | grep $TODAY >> .gateways.html

echo '<h2>Passive gateways</h2>' >> .gateways.html

jq --raw-output -f gateways_to_html.jq .gateways.json | grep -v $TODAY >> .gateways.html

echo '</body></html>' >> .gateways.html

GATEWAYS=$(jq --raw-output ".result | sort_by(.lastSeenAt, .id) | reverse [] | (.id)" .gateways.json)
for g in $GATEWAYS
do
echo "get details for $g"
./get_gateway.sh $TOKEN $g
done
