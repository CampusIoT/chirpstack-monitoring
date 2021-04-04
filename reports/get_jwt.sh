#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# ------------------------------------------------
# Get the JWT token
# ------------------------------------------------

# Parameters
if [[ $# -ne 2 ]] ; then
    echo "Usage: $0 USERNAME PASSWORD"
    exit 1
fi

USERNAME=$1
PASSWORD=$2
AUTH_JSON="{ \"username\": \"${USERNAME}\", \"password\": \"${PASSWORD}\" }"

# Installation
if ! [ -x "$(command -v jq)" ]; then
  >&2 echo 'jq is not installed. Installing jq ...'
  sudo apt-get install -y jq
fi

if ! [ -x "$(command -v curl)" ]; then
  >&2 echo 'curl is not installed. Installing curl ...'
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
DATA_CONFIG_FOLDER="data/configuration/"

# Doc
URL_SWAGGER=${URL}/swagger/api.swagger.json

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

# ===================================
# Get OpenAPI2.0 specification of the API
# -----------------------------------
#${GET} ${URL_SWAGGER} > api.swagger.json

# ===================================
# Authenfication operations
# -----------------------------------

USERNAME_LOWERCASE=${USERNAME,,} #lowercasing the name of json token file for a clean cleaning git ignore.

# Get the Bearer token for the user
rm -f ${DATA_CONFIG_FOLDER}*.token.json #delete old tokens

${POST}  --header "$CONTENT_JSON" -d "$AUTH_JSON" ${URL}/api/internal/login > ${DATA_CONFIG_FOLDER}$USERNAME_LOWERCASE.token.json
TOKEN=$(jq -r '.jwt' ${DATA_CONFIG_FOLDER}$USERNAME_LOWERCASE.token.json)
AUTH="Grpc-Metadata-Authorization: Bearer $TOKEN"
echo "$TOKEN"

#sudo npm install -g jwt-cli
#jwt $TOKEN
