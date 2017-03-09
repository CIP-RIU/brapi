
## GET [/brapi/v1/attributes?attributeCategoryDbId=0]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_germplasmattributes(con, attributeCategoryDbId = "0", rclass = "json")
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
            },
            {
                "attributeDbId": 2,
                "code": "WEV",
                "uri": "http://www.cropontology.org/rdf/CO_3230",
                "name": "Weevil Resistance",
                "description": "Resistance allele",
                "attributeCategoryDbId": 3,
                "attributeCategoryName": "Biotic stress",
                "datatype": "Categorical",
                "values": [
                    "Present",
                    "Absent",
                    "Heterozygous"
                ]
            },
            {
                "attributeDbId": 3,
                "code": "FLSHORG",
                "uri": "http://www.cropontology.org/rdf/CO_3230",
                "name": "Flesh Color Orange allele",
                "description": "Allelele for orange flesh",
                "attributeCategoryDbId": 1,
                "attributeCategoryName": "Morphological",
                "datatype": "Categorical",
                "values": [
                    "Present",
                    "Absent",
                    "Heterozygous"
                ]
            },
            {
                "attributeDbId": 4,
                "code": "FLWCOL",
                "uri": "http://www.cropontology.org/rdf/CO_3230",
                "name": "Flower color white allele",
                "description": "Allele for white flower color",
                "attributeCategoryDbId": 1,
                "attributeCategoryName": "Morphological",
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


