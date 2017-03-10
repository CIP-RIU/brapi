
## GET [/brapi/v1/studies/{studyDbId}/observations?observationVariableDbIds={observationVariableDbIds}]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_studies_observations(con, studyDbId = "1", rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 3,
            "pageSize": 1000
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
                "observationDbId": 1,
                "observationUnitDbId": 1,
                "observationUnitName": "ZIPA_68_Ibadan_2014",
                "observationVariableDbId": 1,
                "observationVariableName": "Yield",
                "observationTimestamp": "11/5/2015 15:12",
                "uploadedBy": 1,
                "operator": "Jane Doe",
                "germplasmDbId": 1,
                "germplasmName": "ZIPA_68",
                "value": 5
            },
            {
                "studyDbId": 1,
                "observationDbId": 2,
                "observationUnitDbId": 2,
                "observationUnitName": "ZIPA_68_Ibadan_2014",
                "observationVariableDbId": 2,
                "observationVariableName": "Carotene",
                "observationTimestamp": "11/5/2015 15:13",
                "uploadedBy": 1,
                "operator": "Jane Doe",
                "germplasmDbId": 1,
                "germplasmName": "ZIPA_68",
                "value": 0.1
            },
            {
                "studyDbId": 1,
                "observationDbId": 3,
                "observationUnitDbId": 3,
                "observationUnitName": "ZIPA_68_Ibadan_2014",
                "observationVariableDbId": 3,
                "observationVariableName": "Fe",
                "observationTimestamp": "11/5/2015 15:14",
                "uploadedBy": 1,
                "operator": "Jane Doe",
                "germplasmDbId": 1,
                "germplasmName": "ZIPA_68",
                "value": 0.081
            }
        ]
    }
}

```


