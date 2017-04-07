
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


