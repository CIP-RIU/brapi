
## GET [/brapi/v1/markers/{markerDbId}]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_markers_details(con, markerDbId = "3", rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "markerDbId": 3,
                "defaultDisplayName": "b_02_10003",
                "type": "Dart",
                "synonyms": [
                    "i_02_10001",
                    "popA_10003"
                ],
                "refAlt": [
                    "C",
                    "G"
                ],
                "analysisMethods": "kasp"
            }
        ]
    }
}

```


