#!/bin/bash

# -------------------------------------------------
# Description:  Generate HTML report of devices
# List Command: x
# Usage:        runned by get_devices.sh
# Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# Milestone: Version 2021
# -------------------------------------------------
# Bug:
# -------------------------------------------------

# DATA REPOSITORY
DATA_DEV_FOLDER="data/devices/"
DATA_HTML_FOLDER="data/generated_files/"
devices_html="${DATA_HTML_FOLDER}.devices.html"

echo '<html><head><title>CampusIoT LNS :: Devices</title></head><body style="font-family:verdana;"><h1>CampusIoT LNS :: Devices</h1>' > ${devices_html}

TODAY=$(date +"%Y-%m-%d")
echo '<p>generated at ' >> ${devices_html}
date +"%Y-%m-%d %T %Z" >> ${devices_html}
echo ' - ' >> ${devices_html}
TZ=GMT date +"%Y-%m-%d %T %Z" >> ${devices_html}
echo '</p>' >> ${devices_html}

echo '<h2>Active devices</h2>' >> ${devices_html}

jq --raw-output -f devices_to_html.jq ${DATA_DEV_FOLDER}.devices.json | grep $TODAY >> ${devices_html}

echo '<h2>Passive devices</h2>' >> ${devices_html}

jq --raw-output -f devices_to_html.jq ${DATA_DEV_FOLDER}.devices.json | grep -v $TODAY >> ${devices_html}

echo '</body></html>' >> ${devices_html}