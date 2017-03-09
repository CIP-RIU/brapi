

## Call: GET [/brapi/v1/maps/{mapDbId}]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_genomemaps_details(con, mapDbId = "1", rclass = "json")
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
    "result": [
        {
            "mapDbId": 1,
            "name": "SSR map 1",
            "type": "Genetic",
            "unit": "cM",
            "linkageGroups": [
                {
                    "linkageGroupId": 1,
                    "numberMarkers": 5,
                    "maxPosition": 50
                },
                {
                    "linkageGroupId": 2,
                    "numberMarkers": 5,
                    "maxPosition": 100
                }
            ]
        }
    ]
}

```


