

## Call: GET [/{apipath}/{crop}/brapi/v1/calls?datatype={dataFile}&pageSize={pageSize}&page={page}]

```r
library(brapi)
library(magrittr)
```

```

Attaching package: 'magrittr'
```

```
The following object is masked from 'package:purrr':

    set_names
```

```
The following object is masked from 'package:tidyr':

    extract
```

```r
# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_calls(con, pageSize = 3,  rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 18,
            "totalCount": 52,
            "pageSize": 3
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "call": "token",
                "datatypes": [
                    [
                        "json",
                        "text"
                    ]
                ],
                "methods": [
                    "POST"
                ]
            },
            {
                "call": "token",
                "datatypes": [
                    [
                        "json",
                        "text"
                    ]
                ],
                "methods": [
                    "DELETE"
                ]
            },
            {
                "call": "calls",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            }
        ]
    }
}

```

## Example 1


```r
json <- ba_calls(con, datatypes = "csv", pageSize = 3, rclass = "json")
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
            "pageSize": 3
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "call": "allelematrix-search",
                "datatypes": [
                    [
                        "json",
                        "csv",
                        "tsv"
                    ]
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "allelematrix-search",
                "datatypes": [
                    [
                        "json",
                        "csv",
                        "tsv"
                    ]
                ],
                "methods": [
                    "POST"
                ]
            },
            {
                "call": "studies/id/table",
                "datatypes": [
                    [
                        "json",
                        "csv",
                        "tsv"
                    ]
                ],
                "methods": [
                    "GET"
                ]
            }
        ]
    }
}

```

