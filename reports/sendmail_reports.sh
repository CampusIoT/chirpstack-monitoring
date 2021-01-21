#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# crontab entry
# TODO    /bin/bash

# TODO get TO for the .config.json
TO="XX.XX@univ-grenoble-alpes.fr YY.YY@univ-grenoble-alpes.fr"
SUBJECT="Monitoring Report"
CONTENT_TYPE="Content-type: text/html"

mail -a "$CONTENT_TYPE" -s "$SUBJECT" -u monitoring $TO <.gateways.html
mail -a "$CONTENT_TYPE" -s "$SUBJECT" -u monitoring $TO <.devices.html

