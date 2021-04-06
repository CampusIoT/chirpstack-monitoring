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

# Parameters
if [[ $# -ne 2 ]] ; then
    echo "Usage: $0 DID OID"
    exit 1
fi

DID="$1/devices"
OID="$2"

tmp=$(grep $DID < .devices.html)
replacement=${tmp/"null"/"$OID"}


if [ -z "$replacement" ]
then
    exit
else
    sed -i "/${DID//\//\\/}/c $replacement" .devices.html
fi