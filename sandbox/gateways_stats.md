# Gateway Stats

## Per day
```bash
curl 'https://lns.campusiot.imag.fr/api/gateways/0000024b08060392/stats?interval=DAY&startTimestamp=2020-01-01T00%3A00%3A00.001Z&endTimestamp=2021-01-01T00%3A00%3A00.001Z' \
-H 'Accept: application/json' \
-H 'Grpc-Metadata-Authorization: Bearer ZZZ.YYY.XXX' \
 | jq .
```

## Per month
```bash
curl 'https://lns.campusiot.imag.fr/api/gateways/0000024b08060392/stats?interval=MONTH&startTimestamp=2020-01-01T00%3A00%3A00.001Z&endTimestamp=2021-01-01T00%3A00%3A00.001Z' \
-H 'Accept: application/json' \
-H 'Grpc-Metadata-Authorization: Bearer ZZZ.YYY.XXX' \
 | jq .
```
