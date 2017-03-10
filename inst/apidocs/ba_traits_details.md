
## GET  [/brapi/v1/traits/{traitDbId}]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process

con <- ba_connect() 

json <- ba_traits_details(con, rclass = "json")
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
            }
        ]
    }
}

```
