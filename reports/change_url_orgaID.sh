#!/bin/bash

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