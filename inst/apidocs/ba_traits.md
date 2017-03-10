
## GET [/brapi/v1/traits]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process

con <- ba_connect() 

json <- ba_traits(con, rclass = "json")
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
                "traitDbId": 1,
                "traitId": "MO_123:0100620",
                "name": "Carotenoid content",
                "description": "Cassava storage root pulp carotenoid content",
                "observationVariables": [
                    "MO_123:0100621",
                    "MO_123:0100623",
                    "MO_123:0100623"
                ],
                "defaultValue": "NA"
            },
            {
                "traitDbId": 2,
                "traitId": "MO_123:0100621",
                "name": "Plant height",
                "description": "Plant height",
                "observationVariables": [
                    "MO_123:0200001"
                ],
                "defaultValue": "NA"
            },
            {
                "traitDbId": 3,
                "traitId": "MO_123:0100622",
                "name": "Root weight",
                "description": "Root weight",
                "observationVariables": [
                    "MO_123:0200002",
                    "MO_1234:0300002"
                ],
                "defaultValue": "NA"
            },
            {
                "traitDbId": 4,
                "traitId": "MO_123:0100623",
                "name": "Root color",
                "description": "Root color",
                "observationVariables": [
                    "MO_123:0200003"
                ],
                "defaultValue": 3
            },
            {
                "traitDbId": 5,
                "traitId": "MO_123:0100624",
                "name": "Virus susceptibility",
                "description": "Virus susceptibility",
                "observationVariables": [
                    "MO_123:0200004"
                ],
                "defaultValue": 5
            }
        ]
    }
}

```
