
## GET [/brapi/v1/studies/{studyDbId}]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_studies_details(con, studiesDbId = "1", rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "pageSize": 0,
            "currentPage": 0,
            "totalCount": 0,
            "totalPages": 0
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "studyDbId": 1,
        "studyName": "Peru Yield Trial 1-1",
        "trialDbId": 1,
        "trialName": "Peru Yield Trial 1",
        "studyType": "Yield study",
        "seasons": [
            "2013 A"
        ],
        "programDbId": 1,
        "programName": "Program 1",
        "startDate": "1/1/2013",
        "endDate": "7/5/2013",
        "active": false,
        "location": {
            "locationDbId": 1,
            "locationType": "Storage location",
            "name": "Experimental station San Ramon (CIP)",
            "abbreviation": "CIPSRM-1",
            "countryCode": "PER",
            "countryName": "Peru",
            "latitude": -11.1275,
            "longitude": -75.3564,
            "altitude": 828,
            "additionalInfo": {
                "local": "San Ramon",
                "crops": "potato, sweetpotato",
                "cont": "South America",
                "creg": "LAC",
                "adm3": "San Ramon",
                "adm2": "Chanchamayo",
                "adm1": "Junin",
                "annualTotalPrecipitation": 360,
                "annualMeanTemperature": 23
            }
        },
        "contacts": [
            {
                "contactDbId": "C0001",
                "name": "M. Bean",
                "email": "m.bean@brapi.org",
                "type": "Scientist",
                "orcid": "0000-0002-0607-8728"
            },
            {
                "contactDbId": "C0002",
                "name": "O. Rice",
                "email": "o.rice@brapi.org",
                "type": "Breeder",
                "orcid": "0000-0002-0607-872"
            }
        ],
        "additionalInfo": {
            "donorName": "Donor1",
            "specialProject": "Project1"
        }
    }
}

```


