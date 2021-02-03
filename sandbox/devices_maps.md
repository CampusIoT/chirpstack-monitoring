# Devices Map

Show a HTML report (status and stats) of located devices into a [leafletjs](https://leafletjs.com/) map
when the location is set into `.location` or `.device.tags[geolocation]`.

```bash
curl 'https://lns.campusiot.imag.fr/api/devices/a81758fffe04b1bc' -H 'Accept: application/json' -H 'Grpc-Metadata-Authorization: Bearer ZZZ.YYY.XX'
```

```json
{
  "device": {
    "devEUI": "a81758fffe04b1bc",
    "name": "ELSYS_EMS_B1BC",
    "applicationID": "36",
    "description": "Elsys EMS",
    "deviceProfileID": "72bc2657-d387-4257-b883-b97e9763997f",
    "skipFCntCheck": false,
    "referenceAltitude": 0,
    "variables": {
      "ThingsBoardAccessToken": "6lOGIM40BOdVRIeOGgGo"
    },
    "tags": {
      "email_owner": "admin@campusiot.imag.fr",
      "geolocation": "45.1902749,5.7670241"
    }
  },
  "lastSeenAt": "2021-02-01T06:23:19.260728Z",
  "deviceStatusBattery": 100,
  "deviceStatusMargin": 28,
  "location": null
}
```
