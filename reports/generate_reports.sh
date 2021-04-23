#!/bin/bash

# -------------------------------------------------
# Description:  Generate gateways and devices reports
# List Command: x
# Usage:        execute ./generate_reports.sh
# Create by:    CampusIoT Dev Team, 2016-2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# Milestone: Version 2021
# -------------------------------------------------

# DATA REPOSITORY
DATA_CONFIG_FOLDER="data/configuration/"

USERNAME=$(jq --raw-output ".username" ${DATA_CONFIG_FOLDER}.credentials.json)
PASSWORD=$(jq --raw-output ".password" ${DATA_CONFIG_FOLDER}.credentials.json)

echo "-------- get_jwt.sh --------"
JWT=$(./get_jwt.sh $USERNAME $PASSWORD)

echo "-------- get_organizations.sh --------"
./get_organizations.sh $JWT
echo "-------- get_gateways.sh --------"
./get_gateways.sh $JWT
echo "-------- get_devices.sh --------"
./get_devices.sh $JWT
