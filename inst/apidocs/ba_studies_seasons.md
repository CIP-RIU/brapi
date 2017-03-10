
## GET [/brapi/v1/seasons?year=&pageSize=&page=]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect() 

args(ba_studies_seasons)
```

```
function (con = NULL, year = 0, page = 0, pageSize = 1000, rclass = "tibble") 
NULL
```

```r
json <- ba_studies_seasons(con, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 16,
            "pageSize": 1000
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "id": 1,
                "season": "spring",
                "year": 2011
            },
            {
                "id": 2,
                "season": "summer",
                "year": 2011
            },
            {
                "id": 3,
                "season": "autumn",
                "year": 2011
            },
            {
                "id": 4,
                "season": "spring",
                "year": 2012
            },
            {
                "id": 5,
                "season": "summer",
                "year": 2012
            },
            {
                "id": 6,
                "season": "spring",
                "year": 2013
            },
            {
                "id": 7,
                "season": "summer",
                "year": 2014
            },
            {
                "id": 8,
                "season": "winter",
                "year": 2015
            },
            {
                "id": 9,
                "season": "summer",
                "year": 2009
            },
            {
                "id": 10,
                "season": "summer",
                "year": 2008
            },
            {
                "id": 11,
                "season": "A",
                "year": 2011
            },
            {
                "id": 12,
                "season": "A",
                "year": 2012
            },
            {
                "id": 13,
                "season": "B",
                "year": 2012
            },
            {
                "id": 14,
                "season": "A",
                "year": 2013
            },
            {
                "id": 15,
                "season": "B",
                "year": 2014
            },
            {
                "id": 16,
                "season": "A",
                "year": 2016
            }
        ]
    }
}

```


