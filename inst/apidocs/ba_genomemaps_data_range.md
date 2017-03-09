
## GET [/brapi/v1/maps/{mapDbId}/positions/{linkageGroupId}?min={min}&max={max}&pageSize={pageSize}&page={page}]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_genomemaps_data_range(con, mapDbId = "1", linkageGroupId = "1", min = 1, max = 1000, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 5,
            "pageSize": 30
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "markerDbId": 1,
                "markerName": "m1",
                "location": 10
            },
            {
                "markerDbId": 2,
                "markerName": "m2",
                "location": 20
            },
            {
                "markerDbId": 3,
                "markerName": "m3",
                "location": 30
            },
            {
                "markerDbId": 4,
                "markerName": "m4",
                "location": 40
            },
            {
                "markerDbId": 5,
                "markerName": "m5",
                "location": 50
            }
        ]
    }
}

```


