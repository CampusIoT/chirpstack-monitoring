# Check health of the Chirpstack LNS

## Prerequises
### Linux
```bash
sudo apt install jq curl
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
* [ ] add organizationID into the device report (join with .applications.json) https://github.com/stedolan/jq/issues/1090
* [x] send reports by email
* [x] crontab for sending reports by email
* [ ] convert date to epoch for computing the time ago
** jq: error (at .gateways.json:0): date "2020-12-21T09:24:02.077751Z" does not match format "%Y-%m-%dT%H:%M:%SZ" (.lastSeenAt | fromdateiso8601)