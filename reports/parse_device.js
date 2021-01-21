/*
# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021
*/
var argv = process.argv;

const fs = require('fs');
const moment = require('moment');

var now = new Date();

// TODO get org_id
const org_id = 0;

try {

    const data = fs.readFileSync(argv[2], 'utf8');

    // parse JSON string to JSON object
    const d = JSON.parse(data);

    var devEUI = d.device.id;
    var applicationID = d.device.applicationID;
    var name = d.device.name;

    var owner_email = d.device.tags.owner_email;
    var owner_email_cc = d.device.tags.owner_email_cc;

    var lastSeenAt = d.lastSeenAt;

    if (lastSeenAt != null && owner_email) {
        lastSeenAt = new Date(lastSeenAt);
        if ((now - lastSeenAt) / 1000 > 3600) {
            var fromNow = moment(lastSeenAt).fromNow();
            console.log(
                //devEUI
                //+ "|" + name
                //+ "|" +
                owner_email
                    //+ "|" + fromNow
                    //+ "|" + lastSeenAt
                    + "|[CampusIoT] Warning: Device " + name + " is down since " + fromNow
                    + "|<p>Device <a href='https://lns.campusiot.imag.fr/#/organizations/" + org_id + "/applications/" + applicationID + "/devices/" + devEUI + '>" + name + "</a> is down since <b>" + fromNow + "</b> (at " + lastSeenAt + ")</p>"
                    + "|" + (owner_email_cc) ? owner_email_cc : ""
            );
        }
    } else {
    }


} catch (err) {
    console.log(`Error reading file from disk: ${err}`);
}
