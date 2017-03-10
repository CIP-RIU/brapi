
## GET [/brapi/v1/locations?locationType={locationType}]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_locations(con, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {

        },
        "status": {

        },
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "locationDbId": 1,
                "locationType": "Storage location",
                "name": "Location 1",
                "abbreviation": "L1",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -11.1275,
                "longitude": -75.3564,
                "altitude": 828,
                "additionalInfo": [
                    {
                        "local": "San Ramon",
                        "cont": "South America",
                        "creg": "LAC",
                        "adm3": "San Ramon",
                        "adm2": "Chanchamayo",
                        "adm1": "Junin",
                        "annualTotalPrecipitation": 360,
                        "annualMeanTemperature": 23
                    }
                ]
            },
            {
                "locationDbId": 2,
                "locationType": "Breeding location",
                "name": "Location 2",
                "abbreviation": "L2",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -11.1612,
                "longitude": -75.3417,
                "altitude": 964,
                "additionalInfo": [
                    {

                    }
                ]
            },
            {
                "locationDbId": 3,
                "locationType": "Storage location",
                "name": "Location 3",
                "abbreviation": "L3",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -12.0763,
                "longitude": -76.9484,
                "altitude": 244,
                "additionalInfo": [
                    {
                        "annualTotalPrecipitation": 6.4,
                        "annualMeanTemperature": 19.2
                    }
                ]
            },
            {
                "locationDbId": 4,
                "locationType": "Farmer field location",
                "name": "Location 4",
                "abbreviation": "L4",
                "countryCode": "MOZ",
                "countryName": "Mozambique",
                "latitude": -15.4669,
                "longitude": 36.9777,
                "altitude": 701,
                "additionalInfo": [
                    {
                        "local": "Gurue",
                        "cont": "Africa",
                        "creg": "SSA",
                        "adm3": "Gurue",
                        "adm2": "Gurue",
                        "adm1": "Zambezia"
                    }
                ]
            },
            {
                "locationDbId": 5,
                "locationType": "Breeding location",
                "name": "Location 5",
                "abbreviation": "L5",
                "countryCode": "MOZ",
                "countryName": "Mozambique",
                "latitude": -26.0283,
                "longitude": 32.39,
                "altitude": 7,
                "additionalInfo": [
                    {
                        "local": "Umbeluzi",
                        "cont": "Africa",
                        "creg": "SSA",
                        "adm3": "Umbeluzi",
                        "adm2": "Boane",
                        "adm1": "Maputo"
                    }
                ]
            },
            {
                "locationDbId": 6,
                "locationType": "Breeding location",
                "name": "Location 6",
                "abbreviation": "L6",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -10.961,
                "longitude": -75.2207,
                "altitude": 717,
                "additionalInfo": [
                    {
                        "altern": "MARANK",
                        "local": "San Miguel Centro Marankiari",
                        "cont": "South America",
                        "creg": "LAC",
                        "adm3": "Peren<e9>",
                        "adm2": "Chanchamayo",
                        "adm1": "Junin"
                    }
                ]
            },
            {
                "locationDbId": 7,
                "locationType": "Breeding location",
                "name": "Location 7",
                "abbreviation": "L7",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -10.9318,
                "longitude": -74.8555,
                "altitude": 484,
                "additionalInfo": [
                    {
                        "altern": "SHIRANI",
                        "local": "Shirani",
                        "cont": "South America",
                        "creg": "LAC",
                        "adm3": "Pichanaki",
                        "adm2": "Chanchamayo",
                        "adm1": "Junin"
                    }
                ]
            },
            {
                "locationDbId": 8,
                "locationType": "Farmer field location",
                "name": "Location 8",
                "abbreviation": "L8",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -11.053,
                "longitude": -73.7525,
                "altitude": 252,
                "additionalInfo": [
                    {
                        "altern": "BETALT",
                        "local": "Betania",
                        "cont": "South America",
                        "creg": "LAC",
                        "adm3": "Rio Tambo",
                        "adm2": "Satipo",
                        "adm1": "Junin"
                    }
                ]
            },
            {
                "locationDbId": 9,
                "locationType": "Farmer field location",
                "name": "Location 9",
                "abbreviation": "L9",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -11.053,
                "longitude": -73.7525,
                "altitude": 252,
                "additionalInfo": [
                    {
                        "altern": "BETBAJ",
                        "local": "Betania",
                        "cont": "South America",
                        "creg": "LAC",
                        "adm3": "Rio Tambo",
                        "adm2": "Satipo",
                        "adm1": "Junin"
                    }
                ]
            },
            {
                "locationDbId": 10,
                "locationType": "Breeding location",
                "name": "Location 10",
                "abbreviation": "L10",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -11.2585,
                "longitude": -73.8208,
                "altitude": 276,
                "additionalInfo": [
                    {
                        "altern": "OVIRI",
                        "local": "Nuevaluz Oviri",
                        "cont": "South America",
                        "creg": "LAC",
                        "adm3": "Rio Tambo",
                        "adm2": "Satipo",
                        "adm1": "Junin"
                    }
                ]
            },
            {
                "locationDbId": 11,
                "locationType": "Breeding location",
                "name": "Location 11",
                "abbreviation": "L11",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -11.1464,
                "longitude": -74.3075,
                "altitude": 323,
                "additionalInfo": [
                    {
                        "altern": "PTOCOPA",
                        "local": "Puerto Ocopa",
                        "cont": "South America",
                        "creg": "LAC",
                        "adm3": "Rio Tambo",
                        "adm2": "Satipo",
                        "adm1": "Junin"
                    }
                ]
            },
            {
                "locationDbId": 12,
                "locationType": "Breeding location",
                "name": "Location 12",
                "abbreviation": "L12",
                "countryCode": "PER",
                "countryName": "Peru",
                "latitude": -11.3082,
                "longitude": -74.6924,
                "altitude": 758,
                "additionalInfo": [
                    {
                        "altern": "SNPEDRO",
                        "local": "San Pedro",
                        "cont": "South America",
                        "creg": "LAC",
                        "adm3": "Coviriali",
                        "adm2": "Satipo",
                        "adm1": "Junin"
                    }
                ]
            },
            {
                "locationDbId": 13,
                "locationType": "Farmer field location",
                "name": "Location 13",
                "abbreviation": "L13",
                "countryCode": "GHA",
                "countryName": "Ghana",
                "latitude": 6.71,
                "longitude": -1.572,
                "altitude": 288,
                "additionalInfo": [
                    {
                        "local": "Fumesua",
                        "cont": "Africa",
                        "creg": "SSA",
                        "adm2": "Ejisu-Juaben",
                        "adm1": "Ashanti"
                    }
                ]
            },
            {
                "locationDbId": 14,
                "locationType": "Farmer field location",
                "name": "Location 14",
                "abbreviation": "L14",
                "countryCode": "GHA",
                "countryName": "Ghana",
                "latitude": 5.123,
                "longitude": -1.462,
                "altitude": 26,
                "additionalInfo": [
                    {
                        "local": "Komenda",
                        "cont": "Africa",
                        "creg": "SSA",
                        "adm1": "Central"
                    }
                ]
            },
            {
                "locationDbId": 15,
                "locationType": "Farmer field location",
                "name": "Location 15",
                "abbreviation": "L15",
                "countryCode": "GHA",
                "countryName": "Ghana",
                "latitude": 10.87,
                "longitude": -1.1466,
                "altitude": 183,
                "additionalInfo": [
                    {
                        "local": "Tono dam",
                        "cont": "Africa",
                        "creg": "SSA",
                        "adm2": "Kassena-Nankana",
                        "adm1": "Upper East"
                    }
                ]
            },
            {
                "locationDbId": 16,
                "locationType": "Storage location",
                "name": "Location 16",
                "abbreviation": "L16",
                "countryCode": "UGA",
                "countryName": "Uganda",
                "latitude": 0.5291,
                "longitude": 32.6125,
                "altitude": 1173,
                "additionalInfo": [
                    {
                        "local": "NaCRRI",
                        "cont": "Africa",
                        "creg": "SSA"
                    }
                ]
            },
            {
                "locationDbId": 17,
                "locationType": "Storage location",
                "name": "Location 17",
                "abbreviation": "L17",
                "countryCode": "UGA",
                "countryName": "Uganda",
                "latitude": 1.528,
                "longitude": 33.616,
                "altitude": 1067,
                "additionalInfo": [
                    {
                        "local": "NaSARRI",
                        "cont": "Africa",
                        "creg": "SSA",
                        "adm1": "Serere"
                    }
                ]
            }
        ]
    }
}

```


