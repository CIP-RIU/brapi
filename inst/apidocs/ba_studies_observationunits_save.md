
## POST [/brapi/v1/studies/{studyDbId}//observationunits]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect() %>% ba_login()
```

```
Authenticated!
```

```r
 df <- as.data.frame(cbind(
    observationUnitDbId = rep(c("abc-123", "abc-456"), each = 2),
    observationDbId = c(1, 2, 3, 4),
    observationVariableId = rep(c(18020, 51496), 2),
    observationVariableName = rep(c("Plant_height", "GW100_g"), 2),
    collector = rep("Mr. Technician", 4),
    observationTimeStamp = rep("2015-06-16T00:53:26Z", 4),
    value = c(11, 111, 22, 222)
  ))

ba_show_info(TRUE)
ba_studies_observationunits_save(
    con,
    studyDbId = "1",
    unitData = df,
    observationLevel = "plot",
    transactionDbId = "1234",
    commit = TRUE
  )
```

```
URL call was: http://127.0.0.1:2021/brapi/v1/studies/1/observationunits?observationLevel=plot
```

```
Server status: 200 (ok)!
```

```
[1] TRUE
```

```r
ba_show_info(FALSE)
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


