// # -------------------------------------------------
// # Description:  Take gateways html file with sparkline javascript ON, and take a picture of it.
// # List Command: x
// # Usage:        runned by get_gateways.sh
// # Create by:    CampusIoT Dev Team, 2021 - Copyright (C) CampusIoT,  - All Rights Reserved
// # -------------------------------------------------
// # Milestone: Version 2021
// # -------------------------------------------------


const webshot = require('webshot');

var link = "file://" + process.cwd() + "/data/generated_files/.gateways.html"

webshot(link, 
'data/images/sparkline_report.png', function(err) {
    if (!err) {
        console.log("Screenshot taken!")
    } else {
        console.log("Bug when generating screeenshot with Sparkline")
    }
});

