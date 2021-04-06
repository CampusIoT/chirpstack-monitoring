#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# -------------------------------------------------
# Description:  Send mails containing reports
# List Command: x
# Usage:        should be runned by generate_reports.sh
# Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# Version:      1.0
# -------------------------------------------------
# Bug:
# -------------------------------------------------

# crontab entry
# TODO    /bin/bash

# ./decompose_gateways_sparkline.sh

# DATA REPOSITORY
DATA_CONFIG_FOLDER="data/configuration/"
DATA_IMAGES_FOLDER="data/images/"

TO=$(jq --raw-output ".report_email_to" ${DATA_CONFIG_FOLDER}.config.json)
SUBJECT="Monitoring Report"
CONTENT_TYPE_HTML="Content-type: text/html"
CONTENT_TYPE_MUL="Content-Type: multipart/mixed; boundary=\"GvXjxJ+pjyke8COw\""
CONTENT_TYPE_IMG="Content-type: image/png"

# CONTENT_TYPE="Content-type: multipart/mixed"
ATTACHMENT="../images/operators.png"

# mail -a "$CONTENT_TYPE" -s "$SUBJECT" -u monitoring $TO <.gateways.html #généré avec pièce jointe
mail -a "$CONTENT_TYPE_HTML" -s "$SUBJECT" -u monitoring $TO <.devices.html

IMAGE="sparkline_report.png"
IMAGE_LOC="${DATA_IMAGES_FOLDER}${IMAGE}"

outputFile=".gateways.html"  
(
echo "To: $TO"
echo "Subject: $SUBJECT"
echo "Mime-Version: 1.0"
echo "$CONTENT_TYPE_MUL"
echo "Content-Disposition: inline" 
echo "" 
echo "--GvXjxJ+pjyke8COw" 
echo "$CONTENT_TYPE_HTML"
echo "Content-Disposition: inline"
cat $outputFile
echo "" 
echo "--GvXjxJ+pjyke8COw"
echo "$CONTENT_TYPE_IMG"
echo "Content-Transfer-Encoding: BASE64"
echo "Content-ID: <envoie sparkline>"
echo "Content-Disposition: attachement; filename=${IMAGE}"
echo "" 
cat $IMAGE_LOC | base64
) | mail -t