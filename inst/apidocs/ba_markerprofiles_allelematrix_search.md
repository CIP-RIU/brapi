
## GET [/brapi/v1/allelematrix-search?unknownString=&sepPhased=&sepUnphased=&expandHomozygotes=&markerprofileDbId=100&markerprofileDbId=101&markerDbId=322&markerDbId=418&format=&pageSize=&page=]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_markerprofiles_allelematrix_search(con, "3", rclass = "json")
```

```
Using GET
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 12,
            "pageSize": 10000
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            [
                "3",
                "1",
                "A/A"
            ],
            [
                "3",
                "2",
                "B/B"
            ],
            [
                "3",
                "3",
                "A|B"
            ],
            [
                "3",
                "4",
                "A|B"
            ],
            [
                "3",
                "5",
                "A/A"
            ],
            [
                "3",
                "6",
                "A/A"
            ],
            [
                "3",
                "7",
                "A/A"
            ],
            [
                "3",
                "8",
                "B/B"
            ],
            [
                "3",
                "9",
                "N"
            ],
            [
                "3",
                "10",
                "A/A"
            ],
            [
                "3",
                "11",
                "B/B"
            ],
            [
                "3",
                "12",
                "A|B"
            ]
        ]
    }
}

```


