#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# crontab entry
# TODO    /bin/bash

# DATA REPOSITORY
DATA_CONFIG_FOLDER="data/configuration/"

TO=$(jq --raw-output ".report_email_to" ${DATA_CONFIG_FOLDER}.config.json)
SUBJECT="Monitoring Report"
CONTENT_TYPE="Content-type: text/html"

mail -a "$CONTENT_TYPE" -s "$SUBJECT" -u monitoring $TO <.gateways.html
mail -a "$CONTENT_TYPE" -s "$SUBJECT" -u monitoring $TO <.devices.html

# mailx -a "$CONTENT_TYPE" -s "$SUBJECT" <.gateways.html "$TO"

echo "mail sended"