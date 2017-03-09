
## GET [/brapi/v1/ontologies?page={page}&pageSize={pageSize}]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_observationvariables_ontologies(con, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 2,
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
                "ontologyDbId": "MO_123",
                "ontologyName": "new crop",
                "authors": "J. Snow, H. Peterson",
                "version": "v1.2",
                "copyright": "2016, INST",
                "licence": "CC BY-SA 4.0"
            },
            {
                "ontologyDbId": "MO_456",
                "ontologyName": "mycrop",
                "authors": "J. Doe",
                "version": "v2",
                "copyright": "",
                "licence": ""
            }
        ]
    }
}

```


