var argv = process.argv;

const fs = require('fs');
const moment = require('moment');

var now = new Date();

try {
    const data = fs.readFileSync(argv[2], 'utf8');

    // parse JSON string to JSON object
    const g = JSON.parse(data);

    var gateway_id = g.gateway.id;
    var org_id = g.gateway.organizationID;
/*
# Copyright (C) CampusIoT,  - All Rights Reserved
# Written by CampusIoT Dev Team, 2016-2021
*/
var name = g.gateway.name;

    var owner_email = g.gateway.tags.owner_email;
    var owner_email_cc = d.device.tags.owner_email_cc;

    var lastSeenAt = g.lastSeenAt;

    if (lastSeenAt != null && owner_email) {
        lastSeenAt = new Date(lastSeenAt);
        if ((now - lastSeenAt) / 1000 > 3600) {
            var fromNow = moment(lastSeenAt).fromNow();
            console.log(
                //gateway_id
                //+ "|" + name
                //+ "|" +
                owner_email
                    //+ "|" + fromNow
                    //+ "|" + lastSeenAt
                    + "|[CampusIoT] Warning: Gateway " + name + " is down since " + fromNow
                    + "|<p>Gateway <a href='https://lns.campusiot.imag.fr/#/organizations/" + org_id + "/gateways/" + gateway_id + "'>" + name + "</a> is down since <b>" + fromNow + "</b> (at " + lastSeenAt + ")</p>"
                    + "|" + (owner_email_cc) ? owner_email_cc : ""
            );
        }
    } else {
    }


} catch (err) {
    console.log(`Error reading file from disk: ${err}`);
}
