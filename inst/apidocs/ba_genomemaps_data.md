
## GET [/brapi/v1/maps/{mapDbId}/positions?linkageGroupId={linkageGroupId}&linkageGroupId={linkageGroupId}&pageSize={pageSize}&page={page}]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_genomemaps_data(con, mapDbId = "1", linkageGroupId = "1", rclass = "json")
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
                "location": 10,
                "linkageGroupId": 1
            },
            {
                "markerDbId": 2,
                "markerName": "m2",
                "location": 20,
                "linkageGroupId": 1
            },
            {
                "markerDbId": 3,
                "markerName": "m3",
                "location": 30,
                "linkageGroupId": 1
            },
            {
                "markerDbId": 4,
                "markerName": "m4",
                "location": 40,
                "linkageGroupId": 1
            },
            {
                "markerDbId": 5,
                "markerName": "m5",
                "location": 50,
                "linkageGroupId": 1
            }
        ]
    }
}

```


