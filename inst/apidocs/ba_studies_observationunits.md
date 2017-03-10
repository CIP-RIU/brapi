
## GET [/brapi/v1/studies/{studyDbId}/observations?observationVariableDbIds={observationVariableDbIds}]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_studies_observationunits(con, studyDbId = "1", rclass = "json")
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
        "data": [
            {
                "observationUnitDbId": 1,
                "observationUnitName": "ZIPA_68_Ibadan_2014",
                "germplasmDbId": 1,
                "germplasmName": "ZIPA_68",
                "pedigree": "A/B",
                "entryNumber": 1,
                "entryType": "test",
                "plotNumber": 1,
                "blockNumber": 1,
                "X": 1,
                "Y": 1,
                "replicate": 1,
                "observations": [
                    {
                        "observationDbId": 1,
                        "observationVariableDbId": 1,
                        "observationVariableName": "Yield",
                        "collector": "Jane Doe",
                        "observationTimeStamp": "2015-11-05 15:12",
                        "value": 5
                    },
                    {
                        "observationDbId": 2,
                        "observationVariableDbId": 2,
                        "observationVariableName": "Carotene",
                        "collector": "Jane Doe",
                        "observationTimeStamp": "2015-11-05 15:13",
                        "value": 0.1
                    },
                    {
                        "observationDbId": 3,
                        "observationVariableDbId": 3,
                        "observationVariableName": "Fe",
                        "collector": "Jane Doe",
                        "observationTimeStamp": "2015-11-05 15:14",
                        "value": 0.081
                    }
                ]
            }
        ]
    }
}

```


