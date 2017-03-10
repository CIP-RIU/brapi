
## GET [/brapi/v1/studies/{studyDbId}/layout]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_studies_layout(con, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "pageSize": 0,
            "currentPage": 0,
            "totalCount": 1,
            "totalPages": 1
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "studyDbId": 1,
                "observationUnitDbId": 10001,
                "observationUnitName": "ZIPA_68_Ibadan_2014",
                "observationLevel": "plot",
                "replicate": 1,
                "germplasmDbId": 101,
                "germplasmName": "ZIPA_68",
                "blockNumber": 1,
                "X": 1,
                "Y": 1,
                "entryType": "test",
                "additionalInfo": {
                    "info2": "comment3"
                }
            },
            {
                "studyDbId": 1,
                "observationUnitDbId": 10002,
                "observationUnitName": "ZIPA_69_Ibadan_2014",
                "observationLevel": "plot",
                "replicate": 1,
                "germplasmDbId": 102,
                "germplasmName": "ZIPA_69",
                "blockNumber": 1,
                "X": 2,
                "Y": 1,
                "entryType": "test",
                "additionalInfo": {

                }
            },
            {
                "studyDbId": 1,
                "observationUnitDbId": 10003,
                "observationUnitName": "Local_variety",
                "observationLevel": "plot",
                "replicate": 1,
                "germplasmDbId": 103,
                "germplasmName": "Local_variety",
                "blockNumber": 1,
                "X": 3,
                "Y": 1,
                "entryType": "check",
                "additionalInfo": {
                    "info1": "comment1",
                    "info2": "comment2"
                }
            },
            {
                "studyDbId": 1,
                "observationUnitDbId": 10004,
                "observationUnitName": "ZIPA_68_Ibadan_2014",
                "observationLevel": "plot",
                "replicate": 2,
                "germplasmDbId": 101,
                "germplasmName": "ZIPA_68",
                "blockNumber": 1,
                "X": 4,
                "Y": 1,
                "entryType": "test",
                "additionalInfo": {

                }
            },
            {
                "studyDbId": 1,
                "observationUnitDbId": 10005,
                "observationUnitName": "ZIPA_69_Ibadan_2014",
                "observationLevel": "plot",
                "replicate": 2,
                "germplasmDbId": 102,
                "germplasmName": "ZIPA_69",
                "blockNumber": 1,
                "X": 5,
                "Y": 1,
                "entryType": "test",
                "additionalInfo": {
                    "info1": "comment4"
                }
            },
            {
                "studyDbId": 1,
                "observationUnitDbId": 10006,
                "observationUnitName": "Local_variety",
                "observationLevel": "plot",
                "replicate": 2,
                "germplasmDbId": 103,
                "germplasmName": "Local_variety",
                "blockNumber": 1,
                "X": 6,
                "Y": 1,
                "entryType": "check",
                "additionalInfo": {

                }
            }
        ]
    }
}

```


