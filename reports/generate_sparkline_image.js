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

