#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# -------------------------------------------------
# Description:  Delete unnecessary files 
# List Command: x
# Usage:        executed by ./clean.sh
# Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# Version:      1.0
# -------------------------------------------------
# Bug:
# -------------------------------------------------

# DATA REPOSITORY
DATA_CONFIG_FOLDER="data/configuration/"
DATA_ORG_FOLDER="data/organizations/"
DATA_APP_FOLDER="data/applications/"
DATA_GAT_FOLDER="data/gateways/"
DATA_DEV_FOLDER="data/devices/"



rm -f ${DATA_CONFIG_FOLDER}*.token.json
rm -f ${DATA_ORG_FOLDER}.organizations.*
rm -f ${DATA_GAT_FOLDER}.gateways.*
rm -f ${DATA_GAT_FOLDER}.gateway-.*
rm -f ${DATA_GAT_FOLDER}.gateway-*
rm -f ${DATA_DEV_FOLDER}.devices.*
rm -f ${DATA_DEV_FOLDER}.application*
rm -f ${DATA_APP_FOLDER}.organization*
