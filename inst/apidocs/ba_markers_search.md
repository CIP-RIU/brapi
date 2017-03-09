
## GET  [/brapi/v1/markers?name={name}&type={type}&matchMethod={matchMethod}&include={synonyms}&pageSize={pageSize}&page={page}]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_markers_search(con, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 5,
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
                "markerDbId": 1,
                "defaultDisplayName": "a_01_10001",
                "type": "SNP",
                "synonyms": [
                    "i_01_10001",
                    "popA_10001"
                ],
                "refAlt": [
                    "A",
                    "T"
                ],
                "analysisMethods": "illumina"
            },
            {
                "markerDbId": 2,
                "defaultDisplayName": "A_01_10002",
                "type": "SNP",
                "synonyms": [
                    "i_01_10001",
                    "popA_10002"
                ],
                "refAlt": [
                    "G",
                    "C"
                ],
                "analysisMethods": "illumina"
            },
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
            },
            {
                "markerDbId": 4,
                "defaultDisplayName": "B_02_10004",
                "type": "Dart",
                "synonyms": [
                    "i_02_10001",
                    "popA_10004"
                ],
                "refAlt": [
                    "T",
                    "A"
                ],
                "analysisMethods": "kasp"
            },
            {
                "markerDbId": 5,
                "defaultDisplayName": "C_11_10005",
                "type": "SNP",
                "synonyms": [
                    "i_11_10001",
                    "popA_10005"
                ],
                "refAlt": [
                    "T",
                    "A"
                ],
                "analysisMethods": [
                    "illumina",
                    "kasp"
                ]
            }
        ]
    }
}

```


