# Chirpstack :: Checkers

Simple checkers of LNS health.

```crontab
0 */2 * * * /bin/bash /home/campusiot/monitoring/check-disk-usage.sh
*/30 * * * * /bin/bash /home/campusiot/monitoring/check-docker-compose.sh
```

> Nagios is cool but too complex now.

