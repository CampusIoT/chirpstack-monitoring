#!/bin/bash

USERNAME=admin
PASSWORD=XXXXXXXXXXXXXXXX

JWT=$(./get_jwt.sh $USERNAME $PASSWORD)

./get_organizations.sh $JWT
./get_gateways.sh $JWT
./get_devices.sh $JWT

# TODO send reports by email
