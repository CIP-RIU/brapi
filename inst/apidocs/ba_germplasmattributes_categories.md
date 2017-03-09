
## GET [/brapi/v1/attributes/categories/?pageSize=10&page=2]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_germplasmattributes_categories(con, pageSize = 2, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 2,
            "totalCount": 3,
            "pageSize": 2
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "attributeCategoryDbId": 1,
                "name": "Morphological"
            },
            {
                "attributeCategoryDbId": 2,
                "name": "Agronomic"
            }
        ]
    }
}

```


