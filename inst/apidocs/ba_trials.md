
## GET  [/brapi/v1/trials]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process

con <- ba_connect() 

args(ba_trials)
```

```
function (con = NULL, programDbId = "any", locationDbId = "any", 
    active = TRUE, sortBy = "none", sortOrder = "asc", page = 0, 
    pageSize = 1000, rclass = "tibble") 
NULL
```

```r
json <- ba_trials(con, rclass = "json")
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
            [
                {
                    "trialDbId": 6,
                    "trialName": "Ghana Yield Trial 3",
                    "programDbId": 3,
                    "name": "Program 3",
                    "startDate": "9/22/2014",
                    "endDate": "3/21/2015",
                    "active": true,
                    "studies": [
                        {
                            "studyDbId": 8,
                            "studyName": "Ghana Yield Trial 3-1",
                            "locationName": "Location 16"
                        }
                    ],
                    "additionalInfo": {

                    }
                }
            ],
            [
                {
                    "trialDbId": 9,
                    "trialName": "Demo Yield Trial",
                    "programDbId": 6,
                    "name": "Program 6",
                    "startDate": "3/24/2016",
                    "endDate": "10/21/2016",
                    "active": true,
                    "studies": [
                        {
                            "studyDbId": 11,
                            "studyName": "Demo Yield Trial",
                            "locationName": "Location 3"
                        }
                    ],
                    "additionalInfo": {
                        "specialProject": "Project1",
                        "fundingUSD": 500000
                    }
                }
            ]
        ]
    }
}

```
