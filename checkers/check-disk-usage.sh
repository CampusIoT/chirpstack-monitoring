#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2022

# Check and alert disk usage and LNS log size

# crontab entry
# Every two hours
# 0 */2 * * * /bin/bash /home/campusiot/monitoring/check-disk-usage.sh

cd /home/campusiot/monitoring

# Parameters
ALERT_ON=95
TO=campusiot@univ-grenoble-alpes.fr
PARTITION="/dev/mapper"

# Variables
CURRENT_USAGE=$(df / | grep $PARTITION | awk '{print $5}' | sed 's/%//g')

# Rule
if [ "$CURRENT_USAGE" -ge "$ALERT_ON" ] ; then

    CONTENT_TYPE="Content-type: text/html"
    SUBJECT="WARNING : LNS Disk Usage too high ($CURRENT_USAGE%)"
    LOG_SIZE=$(ls -alh /home/campusiot/chirpstack-docker/data/mqtt-logger/msg.log | awk '{print $5}')

    mail -a "$CONTENT_TYPE" -s "$SUBJECT" $TO << EOF
<h1>$SUBJECT</h1>
<p>
Disk almost full on $PARTITION partition. Current Usage: $CURRENT_USAGE%
</p>
<p>
LNS Log size : $LOG_SIZE
</p>
EOF

    # Cleaning tmp files
fi
