# Gateway Stats

## Per day
curl 'https://lns.campusiot.imag.fr/api/gateways/0000024b08060392/stats?interval=DAY&startTimestamp=2020-01-03T05%3A23%3A31.310Z&endTimestamp=2021-02-01T05%3A23%3A31.310Z' \
-H 'Accept: application/json' \
-H 'Grpc-Metadata-Authorization: Bearer ZZZ.YYY.XXX' \
 | jq .

## Per month
curl 'https://lns.campusiot.imag.fr/api/gateways/0000024b08060392/stats?interval=MONTH&startTimestamp=2020-01-03T05%3A23%3A31.310Z&endTimestamp=2021-02-01T05%3A23%3A31.310Z' \
-H 'Accept: application/json' \
-H 'Grpc-Metadata-Authorization: Bearer ZZZ.YYY.XXX' \
 | jq .
