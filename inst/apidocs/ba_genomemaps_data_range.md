
## GET [/brapi/v1/maps/{mapDbId}/positions/{linkageGroupId}?min={min}&max={max}&pageSize={pageSize}&page={page}]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_genomemaps_data_range(con, mapDbId = "1", linkageGroupId = "1", min = "1", max = "1000", rclass = "json")
```

```
Error: is.numeric(min) is not TRUE
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
        "data": "new crop"
    }
}

```


