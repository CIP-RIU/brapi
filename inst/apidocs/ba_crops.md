

## Call: GET [/{apipath}/{crop}/brapi/v1/crops]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_crops(con, rclass = "json")
```

```
URL call was: http://127.0.0.1:2021/brapi/v1/crops
```

```
Server status:  ok!
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
