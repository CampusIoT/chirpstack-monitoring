# CampusIoT :: Chirpstack :: Monitoring :: Dashboard

## Web site
* https://admin.iot.imag.fr for Grafana
* https://admin-n.iot.imag.fr for NodeRED

## Layout
* configuration: contains containers' configurations
* data: contains containers' data (rw)
* backups: contains backups of the databases and messages log
* docker: contains the build of the containers
* screenshots: contains screenshots of the dashboards

## Ports
* nodered : TBD
* grafana : TBD
* influxdb : TBD
* thingsboard : TBD

## Configuration

### Servers address
TODO


### Credentials
TODO
#### Grafana

#### NodeRED
in settings.js
```
    // Securing Node-RED
    // -----------------
    // To password protect the Node-RED editor and admin API, the following
    // property can be used. See http://nodered.org/docs/security.html for details.
    adminAuth: {
        type: "credentials",
        users: [{
            username: "admin",
            password: "$2a$08$ff.hh",
            permissions: "*"
        }]
    },

    // To password protect the node-defined HTTP endpoints (httpNodeRoot), or
    // the static content (httpStatic), the following properties can be used.
    // The pass field is a bcrypt hash of the password.
    // See http://nodered.org/docs/security.html#generating-the-password-hash
    httpNodeAuth: {user:"user",pass:"$2a$08$ff/hh"},
    httpStaticAuth: {user:"user",pass:"$2a$08$ff/hh"},
```


#### InfluxDB


## Database
The name is `lorawan`

## Operations

```
# launch the composition
docker-compose up -d

# list the containers of the composition
docker-compose ps

# follow the logs of the containers
docker-compose logs -f

# stop the composition
docker-compose stop

# start the composition
docker-compose start

# destroy all the containers of the composition
docker-compose down
```

## TODO
