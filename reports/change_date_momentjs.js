// # -------------------------------------------------
// # Description:  Change the Format of Date in gateways.html and devices.html
// # List Command: x
// # Usage:        runned by get_id_gateways_change.sh and get_id_devices_change.sh
// # Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
// # -------------------------------------------------
// # Milestone: Version 2021
// # -------------------------------------------------

const moment = require('moment');

var argv = process.argv; // store the argument given
process.argv.shift(); // skip path of node file
process.argv.shift(); // skip path of js file
argv = process.argv.join(" ") // parse to keep only the string

function f(lastSeenAt) {
    lastSeenAt = new Date(lastSeenAt);
    return moment(lastSeenAt).fromNow();
}
console.log(f(argv))