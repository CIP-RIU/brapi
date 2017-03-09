
## GET [/brapi/v1/germplasm/{germplasmDbId}/attributes?attributeList={attributeDbId},{attributeDbId}&pageSize=&page=]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_germplasmattributes_details(con, germplasmDbId = "1",  rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 1,
            "pageSize": 10
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "germplasmDbId": 1,
        "data": [
            {
                "attributeDbId": 1,
                "attributeName": "Morphological",
                "attributeCode": "FLSHORG",
                "value": "Present",
                "dateDetermined": 20160101
            }
        ]
    }
}

```


