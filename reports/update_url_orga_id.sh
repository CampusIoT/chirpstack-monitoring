#!/bin/bash

# -------------------------------------------------
# Description:  add organization ID into URL 
# List Command: x
# Usage:        runned by get_devices.sh
# Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# Version:      1.0
# -------------------------------------------------
# Bug:
# -------------------------------------------------

DATA_HTML_FOLDER="data/generated_files/"
devices_html="${DATA_HTML_FOLDER}.devices.html"

# Parameters
if [[ $# -ne 2 ]] ; then
    echo "Usage: $0 DID OID"
    exit 1
fi

DID="$1/devices"
OID="$2"

tmp=$(grep $DID < ${devices_html})
replacement=${tmp/"null"/"$OID"}


if [ -z "$replacement" ]
then
    exit
else
    sed -i "/${DID//\//\\/}/c $replacement" ${devices_html}
fi