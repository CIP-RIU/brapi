
## GET [/brapi/v1/studyTypes?pageSize=&page=]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect() 

json <- ba_studies_studytypes(con, rclass = "json")
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
                "name": "Crossing Nursery",
                "description": "Description for Nursery study type"
            },
            {
                "name": "Yield Trial",
                "description": "Description for Trial study type"
            },
            {
                "name": "Genotype",
                "description": "Description for Genotyping study type"
            }
        ]
    }
}

```


