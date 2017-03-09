

## Call: GET [/brapi/v1/maps?species={speciesId}&pageSize={pageSize}&page={page}&type={type}]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_genomemaps(con, rclass = "json")
```

```
URL call was: http://127.0.0.1:2021/brapi/v1/maps/?page=0&pageSize=30&
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
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 3,
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
                "mapDbId": 1,
                "name": "SSR map 1",
                "species": "Fructus novus",
                "type": "Genetic",
                "unit": "cM",
                "publishedDate": "6/1/2016",
                "markerCount": 10,
                "linkageGroupCount": 2,
                "comments": ""
            },
            {
                "mapDbId": 2,
                "name": "SSR map 2",
                "species": "Fructus novus",
                "type": "Genetic",
                "unit": "cM",
                "publishedDate": "11/15/2016",
                "markerCount": 10,
                "linkageGroupCount": 1,
                "comments": "none"
            },
            {
                "mapDbId": 3,
                "name": "GBS genomic map",
                "species": "Fructus novus",
                "type": "Physical",
                "unit": "bp",
                "publishedDate": "12/1/2016",
                "markerCount": 20,
                "linkageGroupCount": 3,
                "comments": "whatever"
            }
        ]
    }
}

```


