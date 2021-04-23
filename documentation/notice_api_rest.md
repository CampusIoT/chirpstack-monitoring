# How to use it efficiently with reports:
link : https://lns.campusiot.imag.fr/api#/

The API is a very great tool to understand how to acces to data of the server. it will generate for you the jq and curl command to directly acces to each ressource stocked on the server.

First of all, you need to take the token that you will put on the right top of the page. If you had already run once the generation of reports, you can get your token in the repo : `reports/data/configuration/` in a json file containing "token" in the name.

You are ready to do any acces.

## Specifications 

Imagine we want to get a gateway. you can display Model or an Example of what your json will looks like : 

**Model**
```C
 apiListGatewayResponse {
result (Array[apiGatewayListItem], optional):

Nodes within this result-set. ,
totalCount (string, optional):

Total number of nodes available within the result-set.
}
apiGatewayListItem {
createdAt (string, optional):

Create timestamp. ,
description (string, optional):

A description for the gateway ,
firstSeenAt (string, optional):

First seen timestamp. ,
id (string, optional):

Gateway ID (HEX encoded). ,
lastSeenAt (string, optional):

Last seen timestamp. ,
location (commonLocation, optional):

Location. ,
name (string, optional):

A name for the gateway ,
networkServerID (string, optional):

Network-server ID. ,
organizationID (string, optional):

Organization ID. ,
updatedAt (string, optional):

Last update timestamp.
}
commonLocation {
accuracy (integer, optional):

Accuracy (in meters). ,
altitude (number, optional):

Altitude. ,
latitude (number, optional):

Latitude. ,
longitude (number, optional):

Longitude. ,
source (string, optional):

    UNKNOWN: Unknown.
    GPS: GPS.
    CONFIG: Manually configured.
    GEO_RESOLVER: Geo resolver.

= ['UNKNOWN', 'GPS', 'CONFIG', 'GEO_RESOLVER']
string
Default:	UNKNOWN
Enum:	"UNKNOWN", "GPS", "CONFIG", "GEO_RESOLVER"
} 
```


**Example**
```json
{
  "result": [
    {
      "createdAt": "2021-04-07T01:08:12.614Z",
      "description": "string",
      "firstSeenAt": "2021-04-07T01:08:12.614Z",
      "id": "string",
      "lastSeenAt": "2021-04-07T01:08:12.614Z",
      "location": {
        "accuracy": 0,
        "altitude": 0,
        "latitude": 0,
        "longitude": 0,
        "source": "UNKNOWN"
      },
      "name": "string",
      "networkServerID": "string",
      "organizationID": "string",
      "updatedAt": "2021-04-07T01:08:12.614Z"
    }
  ],
  "totalCount": "string"
}
```

Click on "Try it out" to get the command line you are looking for.
