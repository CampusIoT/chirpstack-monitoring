#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# ------------------------------------------------
# Parse getaways
# ------------------------------------------------

rm .mails.csv
GWIDS=$(jq --raw-output ".result | sort_by(.lastSeenAt, .id) | reverse [] | (.id)" .gateways.json)
for GWID in $GWIDS
do
node ./parse_gateway.js .gateway-${GWID}.json >> .mails.csv
done


CONTENT_TYPE="Content-type: text/html"

while IFS="|" read -r TO SUBJECT BODY
do
# TODO add cc:
echo "$BODY" | mail -a "$CONTENT_TYPE" -s "$SUBJECT" -u monitoring $TO
done < .mails.csv