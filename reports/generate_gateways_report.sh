#!/bin/bash

# -------------------------------------------------
# Description:  Generate HTML report of gateways
# List Command: x
# Usage:        runned by get_gateways.sh
# Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
# -------------------------------------------------
# Milestone: Version 2021
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
DATA_HTML_FOLDER="data/generated_files/"
gateways_html="${DATA_HTML_FOLDER}.gateways.html"
gateways_without_spark_html="${DATA_HTML_FOLDER}.gateways_without_sparkline.html"

GATEWAYS=${@:2:$GATEWAYS_LENGTH} # We get data from the gateway which is passed in parameter and we are replacing the length and date time
TODAY="${@:$#}"                  # last parameter

# gateways_to_html : Step 1 : Generate header.
cat header_sparkline.html >${gateways_html}
echo '<title>CampusIoT LNS :: Gateways</title>' >>${gateways_html}
echo '</head>' >>${gateways_html}
echo '<body style="font-family:verdana;"><h1>CampusIoT LNS :: Gateways</h1>' >>${gateways_html}

# 2.Generate Time
echo '<p>generated at ' >>${gateways_html}
date +"%Y-%m-%d %T %Z" >>${gateways_html}
echo ' - ' >>${gateways_html}
TZ=GMT date +"%Y-%m-%d %T %Z" >>${gateways_html}
echo '</p>' >>${gateways_html}

# Create a copy of .gateways.html to get one with sparkline data, and one without them
cp ${gateways_html} ${gateways_without_spark_html}

# 3.Generate Active Gateways without sparkline data
echo '<h2>Active gateways</h2>' >>${gateways_without_spark_html}

for g in $GATEWAYS; do
    jq --raw-output "(  \"<li><a \" 
        + \"href='https://lns.campusiot.imag.fr/#/organizations/\(.gateway.organizationID)/gateways/\(.gateway.id)'\" + \">\" + .gateway.id + \"</a>: \"
        + .gateway.name + \" - (org \" + .gateway.organizationID + \") - \"
        + .lastSeenAt
    + \"</li>\" )" ${DATA_GAT_FOLDER}.gateway-${g}.json | grep $TODAY >>${gateways_without_spark_html}
done

# 4.Generate Passive Gateways without sparkline data
echo '<h2>Passive gateways</h2>' >>${gateways_without_spark_html}
for g in $GATEWAYS; do

    jq --raw-output "(  \"<li><a \" 
        + \"href='https://lns.campusiot.imag.fr/#/organizations/\(.gateway.organizationID)/gateways/\(.gateway.id)'\" + \">\" + .gateway.id + \"</a>: \"
        + .gateway.name + \" - (org \" + .gateway.organizationID + \") - \"
        + .lastSeenAt 
    + \"</li>\" )" ${DATA_GAT_FOLDER}.gateway-${g}.json | grep -v $TODAY >>${gateways_without_spark_html}

done

echo '</body></html>' >>${gateways_html}

# 5.Generate Active Gateways with sparkline data
echo '<h2>Active gateways</h2>' >>${gateways_html}

for g in $GATEWAYS; do

    packet_received=$(jq -r '.result | map(.rxPacketsReceivedOK|tostring) | join(",")' ${DATA_GAT_FOLDER}.gateway-${g}_stats.json)
    
    jq --raw-output "(  \"<li><a \" 
        + \"href='https://lns.campusiot.imag.fr/#/organizations/\(.gateway.organizationID)/gateways/\(.gateway.id)'\" + \">\" + .gateway.id + \"</a>: \"
        + .gateway.name + \" - (org \" + .gateway.organizationID + \") - \"
        + .lastSeenAt 
        + \" - packets received last month : <span class='inlinesparkline'>${packet_received}</span>\" 
    + \"</li>\" )" ${DATA_GAT_FOLDER}.gateway-${g}.json | grep $TODAY >>${gateways_html}
done

# 6.Generate Passive Gateways with sparkline data
echo '<h2>Passive gateways</h2>' >>${gateways_html}
for g in $GATEWAYS; do

    packet_received=$(jq -r '.result | map(.rxPacketsReceivedOK|tostring) | join(",")' ${DATA_GAT_FOLDER}.gateway-${g}_stats.json)

    jq --raw-output "(  \"<li><a \" 
        + \"href='https://lns.campusiot.imag.fr/#/organizations/\(.gateway.organizationID)/gateways/\(.gateway.id)'\" + \">\" + .gateway.id + \"</a>: \"
        + .gateway.name + \" - (org \" + .gateway.organizationID + \") - \"
        + .lastSeenAt 
        + \" - packets received last month : <span class='inlinesparkline'>${packet_received}</span>\" 
    + \"</li>\" )" ${DATA_GAT_FOLDER}.gateway-${g}.json | grep -v $TODAY >>${gateways_html}

done

echo '</body></html>' >>${gateways_html}
