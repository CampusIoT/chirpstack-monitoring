#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# ------------------------------------------------
# Generate the reports
# ------------------------------------------------

USERNAME=$(jq --raw-output ".username" .credentials.json)
PASSWORD=$(jq --raw-output ".password" .credentials.json)

JWT=$(./get_jwt.sh $USERNAME $PASSWORD)

#./get_organizations.sh $JWT
./get_gateways_v2.sh $JWT
#./get_devices.sh $JWT

# TODO send reports by email
