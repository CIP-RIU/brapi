
## GET [/brapi/v1/studies/{studyDbId}/observations?observationVariableDbIds={observationVariableDbIds}]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_studies_observationlevels(con, rclass = "json")
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
            "plant",
            "plot"
        ]
    }
}

```


