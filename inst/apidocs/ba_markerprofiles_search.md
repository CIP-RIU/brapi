
## GET [/brapi/v1/markerprofiles/{germplasmDbId}?unknownString=&sepPhased=&sepUnphased=&expandHomozygotes=&pageSize=&page= ]

## POST [/brapi/v1/markerprofiles-search?germplasm={germplasmDbId}&studyDbId={studyDbId}&sample={sampleDbId}&extract={extractDbId}&method={methodDbId}&pageSize=100&page=4]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_markerprofiles_search(con, germplasmDbId = "3", rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 1,
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
                "sampleDbId": 33,
                "extractDbId": 1,
                "studyDbId": 1,
                "analysisMethod": "GBS",
                "resultCount": 12
            }
        ]
    }
}

```


