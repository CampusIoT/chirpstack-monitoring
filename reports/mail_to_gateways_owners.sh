#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# ------------------------------------------------
# Parse getaways and send reports to owners by email
# ------------------------------------------------

# DATA REPOSITORY
DATA_GAT_FOLDER="data/gateways/"
DATA_GENERATED_FOLDER="data/generated_files/"

rm .mails.csv
GWIDS=$(jq --raw-output ".result | sort_by(.lastSeenAt, .id) | reverse [] | (.id)" .gateways.json)
for GWID in $GWIDS
do
node ./parse_gateway.js ${DATA_GAT_FOLDER}.gateway-${GWID}.json >> ${DATA_GENERATED_FOLDER}.mails.csv
done


CONTENT_TYPE="Content-type: text/html"

while IFS="|" read -r TO SUBJECT BODY
do
# TODO add cc:
echo "$BODY" | mail -a "$CONTENT_TYPE" -s "$SUBJECT" -u monitoring $TO
done < .mails.csv