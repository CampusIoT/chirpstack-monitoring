# Check health of the Chirpstack LNS

## Prerequises
### Linux
```bash
sudo apt install mail postfix
sudo apt install jq curl
```

[See Postfix install](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-on-ubuntu-20-04)

```bash
npm install moment #javascript timer lib (generate reports)
sudo apt-get install -y phantomjs #javascript screenshot html page lib (send reports by emails)
npm install webshot #come with phantomjs for the screenshot (send reports by emails)
npm install graceful-fs #come with phantomjs for the screenshot (send reports by emails)
```

### MacOS
```bash
brew install jq curl
```

## Configure

```bash
cp config.tmpl.json .config.json
cp credentials.tmpl.json .credentials.json
```
Edit `.config.json` and `.credentials.json`

Then edit the crontab with `crontab -e` and add the following line into the crontab 
```
0 12 * * * /bin/bash /home/campusiot/chirpstack-monitoring/reports/cron.sh
```

## Generate reports

```bash
./generate_reports.sh
open .gateways.html
open .applications.html
open .devices.html
open .organizations.html
```

## Send reports by email
```bash
./sendmail_reports.sh
```

## Send gateway alert by email to their owners
> The owner's email address should be configured into the tag "owner_email" of the gateway description on the LNS console
```bash
./mail_to_gateways_owners.sh
open .mails.csv
```

## Cleans bins files
```bash
./clean.sh
```

## Useful utilities
* https://www.npmjs.com/package/csvtojson
* https://www.npmjs.com/package/jsontocsv
* https://stedolan.github.io/jq/manual/

```bash
sudo npm install -g csvtojson
csvtojson --help
sudo npm install -g jsontocsv
jsontocsv --help
```

```bash
jq '[.[] | {"name":.name, "deveui":.deveui, "appkey":.appkey}]'  fulldevices.json > devices.json
```

### TODOLIST

* [x] send email to the persons (one or more) responsible of a failed gateway. responsibles are set into the tag "owner_email" into the gateway description on the LNS
* [x] add organizationID into the device report (join with .applications.json) https://github.com/stedolan/jq/issues/1090
* [x] send reports by email
* [x] crontab for sending reports by email
* [x] convert date to epoch for computing the time ago
* [ ] Instead of taking a capture of the whole page html, take a picture of each sparkline graph and
replace it through the mail. (check documentation file Final_Report_Team18_2021.pdf part "Possible Improvement" for further informations )