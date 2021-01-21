
(cd ~/chirpstack-docker; docker-compose ps)
df -h
docker system df
docker system df --verbose
docker stats $(docker ps --format={{.Names}}) --no-stream

