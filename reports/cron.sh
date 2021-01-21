#!/bin/bash

# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021

# crontab entry
# Every day at noon
# 0 12 * * * /bin/bash /home/campusiot/chirpstack-monitoring/reports/cron.sh
cd ~/chirpstack-monitoring/reports/cron.sh
./generate_reports.sh

./sendmail_reports.sh

./mail_to_gateways_owners.sh 
