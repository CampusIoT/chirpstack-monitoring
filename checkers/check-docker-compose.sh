#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2022

# Check if all the services of the LNS are UP 

# TODO add the list of services which are not UP

# crontab entry
# Every 30 minutes
# */30 * * * * /bin/bash /home/campusiot/monitoring/check-docker-compose.sh

cd /home/campusiot/monitoring

# Parameters
SERVICE_NUM=11
TO="campusiot@univ-grenoble-alpes.fr"

# Variables
(cd /home/campusiot/chirpstack-docker; /usr/local/bin/docker-compose ps) > .docker-compose.output
UP_COUNT=$(grep Up .docker-compose.output | wc -l)
DOWN_COUNT=$(expr $SERVICE_NUM - $UP_COUNT)

# Rule
if [ "$UP_COUNT" -lt "$SERVICE_NUM" ] ; then
    CONTENT_TYPE="Content-type: text/html"
    SUBJECT="WARNING : Some LTN services are down ($DOWN_COUNT/$SERVICE_NUM)"
    (echo "<h1>$SUBJECT</h1>"; echo '<pre>'; grep -v Up .docker-compose.output; echo '</pre>') > .mail.html
    mail -a "$CONTENT_TYPE" -s "$SUBJECT" $TO < .mail.html

    # Cleaning tmp files
    rm .mail.html
fi

# Cleaning tmp files
rm .docker-compose.output
