const webshot = require('webshot');

webshot('file:///home/blanquan/Bureau/2019-2022_Polytech/2emeAnnee/Tronc_Info/projet_campus_iot/chirpstack-monitoring/reports/.gateways.html', 
'data/images/sparkline_report.png', function(err) {
    if (!err) {
        console.log("Screenshot taken!")
    } else {
        console.log("Bug when generating screeenshot")
    }
});
