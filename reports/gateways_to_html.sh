#!/bin/bash

# -------------------------------------------------
# Description:  Generate HTML report of gateways
# List Command: x
# Usage:        runned by get_gateways.sh (à détailler)
# Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# Since:        09/09/2560 (DD/MM/YYYY)
# -------------------------------------------------
# Version:      1.0
# -------------------------------------------------
# Bug:
# -------------------------------------------------

# Parameters
if [[ $# -eq 0 ]]; then
    echo "No arguments : Usage: $0 GATEWAYS_LENGTH GATEWAYS TODAY"
    exit 1
fi

GATEWAYS_LENGTH="$1"
args_len=$(($GATEWAYS_LENGTH + 2))

if [[ $# -ne args_len ]]; then
    echo "Usage: $0 GATEWAYS_LENGTH GATEWAYS TODAY"
    exit 1
fi

# DATA REPOSITORY
DATA_APP_FOLDER="data/applications/"
DATA_GAT_FOLDER="data/gateways/"

GATEWAYS=${@:2:$GATEWAYS_LENGTH} # We get data from the gateway which is passed in parameter and we are replacing the length and date time
TODAY="${@:$#}"                  # last parameter

# gateways_to_html : Step 1 : Generate header.
cat report_header.html >.gateways.html
echo '<title>CampusIoT LNS :: Gateways</title>' >>.gateways.html
echo '</head>' >>.gateways.html
echo '<body style="font-family:verdana;"><h1>CampusIoT LNS :: Gateways</h1>' >>.gateways.html

# 2.Generate Time
echo '<p>generated at ' >>.gateways.html
date +"%Y-%m-%d %T %Z" >>.gateways.html
echo ' - ' >>.gateways.html
TZ=GMT date +"%Y-%m-%d %T %Z" >>.gateways.html
echo '</p>' >>.gateways.html

# 3.Generate Active Gateways
echo '<h2>Active gateways</h2>' >>.gateways.html

echo "generate_sparkline_packets : \n ========== \n ========== \n "

for g in $GATEWAYS; do

    packet_received=$(jq -r '.result | map(.rxPacketsReceivedOK|tostring) | join(",")' ${DATA_GAT_FOLDER}.gateway-${g}_stats.json)
    
    jq --raw-output "(  \"<li><a \" 
        + \"href='https://lns.campusiot.imag.fr/#/organizations/\(.gateway.organizationID)/gateways/\(.gateway.id)'\" + \">\" + .gateway.id + \"</a>: \"
        + .gateway.name + \" - (org \" + .gateway.organizationID + \") - \"
        + .lastSeenAt 
        + \" - packets received last month : <span class='inlinesparkline'>${packet_received}</span>\" 
    + \"</li>\" )" ${DATA_GAT_FOLDER}.gateway-${g}.json | grep $TODAY >>.gateways.html
done

# 4.Generate Passive Gateways
echo '<h2>Passive gateways</h2>' >>.gateways.html
for g in $GATEWAYS; do

    packet_received=$(jq -r '.result | map(.rxPacketsReceivedOK|tostring) | join(",")' ${DATA_GAT_FOLDER}.gateway-${g}_stats.json)

    jq --raw-output "(  \"<li><a \" 
        + \"href='https://lns.campusiot.imag.fr/#/organizations/\(.gateway.organizationID)/gateways/\(.gateway.id)'\" + \">\" + .gateway.id + \"</a>: \"
        + .gateway.name + \" - (org \" + .gateway.organizationID + \") - \"
        + .lastSeenAt 
        + \" - packets received last month : <span class='inlinesparkline'>${packet_received}</span>\" 
    + \"</li>\" )" ${DATA_GAT_FOLDER}.gateway-${g}.json | grep -v $TODAY >>.gateways.html

done

echo '</body></html>' >>.gateways.html
