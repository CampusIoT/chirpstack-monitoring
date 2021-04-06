const webshot = require('webshot');

webshot('file:./data/generated_files/.gateways.html', 
'data/images/sparkline_report.png', function(err) {
    if (!err) {
        console.log("Screenshot taken!")
    } else {
        console.log("Bug when generating screeenshot with Sparkline")
    }
});
