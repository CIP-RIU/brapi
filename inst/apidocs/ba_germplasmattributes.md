
## GET [/brapi/v1/attributes?attributeCategoryDbId=2]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_germplasmattributes(con, attributeCategoryDbId = '2', rclass = "json")
```

```
URL call was: http://127.0.0.1:2021/brapi/v1/attributes/?attributeCategoryDbId=2
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
            "pageSize": 10000,
            "currentPage": 0,
            "totalCount": 4,
            "totalPages": 1
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "attributeDbId": 1,
                "code": "RHT",
                "uri": "http://www.cropontology.org/rdf/CO_321:0000020",
                "name": "Rht-B1b",
                "description": "Allele of marker 11_4769, diagnostic for allele b of reduced-height gene Rht-B1",
                "attributeCategoryDbId": 2,
                "attributeCategoryName": "Agronomic",
                "datatype": "Categorical",
                "values": [
                    "Present",
                    "Absent",
                    "Heterozygous"
                ]
            }
        ]
    }
}

```


