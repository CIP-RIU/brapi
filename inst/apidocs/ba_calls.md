

## Call: [/{apipath}/{crop}/brapi/v1/calls?datatype={dataFile}&pageSize={pageSize}&page={page}]

```r
json <- ba_calls(con, pageSize = 3,  rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 15,
            "totalCount": 44,
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
                    [
                        "POST",
                        "DELETE"
                    ]
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
            },
            {
                "call": "crops",
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
json <- ba_calls(con, datatypes = "json", pageSize = 3, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 15,
            "totalCount": 44,
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
                    [
                        "POST",
                        "DELETE"
                    ]
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
            },
            {
                "call": "crops",
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

