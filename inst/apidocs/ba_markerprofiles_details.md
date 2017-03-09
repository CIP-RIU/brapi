
## GET [/brapi/v1/markerprofiles/{germplasmDbId}?unknownString=&sepPhased=&sepUnphased=&expandHomozygotes=&pageSize=&page= ]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_markerprofiles_details(con, markerprofilesDbId = "3", rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 12,
            "pageSize": 10000
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "germplasmDbId": 3,
                "markerProfilesDbId": 3,
                "uniqueDisplayName": "germplasm3",
                "extractDbId": 1,
                "analysisMethod": "GBS",
                "data": [
                    {
                        "m1": "A/A"
                    },
                    {
                        "m2": "B/B"
                    },
                    {
                        "m3": "A|B"
                    },
                    {
                        "m4": "A|B"
                    },
                    {
                        "m5": "A/A"
                    },
                    {
                        "m6": "A/A"
                    },
                    {
                        "m7": "A/A"
                    },
                    {
                        "m8": "B/B"
                    },
                    {
                        "m9": "N"
                    },
                    {
                        "m10": "A/A"
                    },
                    {
                        "m11": "B/B"
                    },
                    {
                        "m12": "A|B"
                    }
                ]
            }
        ]
    }
}

```


