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