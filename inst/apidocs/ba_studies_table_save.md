
## POST [/brapi/v1/studies/{studyDbId}/table]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process

con <- ba_connect() 
con$bms <- TRUE
con <- ba_login(con)
```

```
Authenticated!
```

```r
  df <- as.data.frame(cbind(
    observationUnitDbId = 1:2, # obligatory variable
    collector = c("T1", "T2"), # obligatory variable
    observationTimestamp = c("ts 1", "ts 2"), # obligatory variable
    variable1Id = c(3, 4)
  ))
  
  ba_show_info(TRUE)
  ba_studies_table_save(con, "1",  study_table = df)
```

```
{
  "metadata": {
    "pagination": {
      "pageSize": [0],
      "currentPage": [0],
      "totalCount": [0],
      "totalPages": [0]
    },
    "status": [],
    "datafiles": []
  },
  "result": {
    "headerRow": ["observationUnitDbId", "collector", "observationTimestamp", "variable1Id"],
    "observationVariableDbIds": ["variable1Id"],
    "data": [
      ["1", "T1", "ts 1", "3"],
      ["2", "T2", "ts 2", "4"]
    ]
  }
}
```

```
URL call was: http://127.0.0.1:2021/brapi/v1/studies/1/table/
```

```
Server status: 200 (ok)!
```

```r
  ba_show_info(FALSE)
```
