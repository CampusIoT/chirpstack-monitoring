#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# ------------------------------------------------
# Generate the reports
# ------------------------------------------------

USERNAME=ChirpstackMonitoring
PASSWORD=qX2bK6oN2iC1cQ5c

JWT=$(./get_jwt.sh $USERNAME $PASSWORD)

./get_organizations.sh $JWT
#./get_gateways.sh $JWT
./get_devices.sh $JWT

# TODO send reports by email
