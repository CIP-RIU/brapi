
## GET [/brapi/v1/trials/{trialDbId}]


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
json <- ba_trials_details(con, rclass = "json")
```
### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "pageSize": 1000,
            "currentPage": 0,
            "totalCount": 1,
            "totalPages": 1
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
                    "trialDbId": 1,
                    "trialName": "Peru Yield Trial 1",
                    "programDbId": 1,
                    "name": "Program 1",
                    "startDate": "1/1/2013",
                    "endDate": "7/5/2013",
                    "active": false,
                    "studies": [
                        {
                            "studyDbId": 1,
                            "studyName": "Peru Yield Trial 1-1",
                            "locationName": "Location 1"
                        }
                    ],
                    "additionalInfo": {
                        "donorName": "Donor1",
                        "specialProject": "Project1"
                    }
                }
            ],
            [
                {
                    "trialDbId": 2,
                    "trialName": "Peru Yield Trial 2",
                    "programDbId": 1,
                    "name": "Program 1",
                    "startDate": "6/1/2014",
                    "endDate": "1/15/2015",
                    "active": false,
                    "studies": [
                        {
                            "studyDbId": 2,
                            "studyName": "Peru Yield Trial 2-1",
                            "locationName": "Location 2"
                        }
                    ],
                    "additionalInfo": {

                    }
                }
            ],
            [
                {
                    "trialDbId": 3,
                    "trialName": "Ghana Genotype Trial 1",
                    "programDbId": 2,
                    "name": "Program 2",
                    "startDate": "5/1/2011",
                    "endDate": "12/15/2011",
                    "active": false,
                    "studies": [
                        {
                            "studyDbId": 3,
                            "studyName": "Ghana Yield Trial MET 1",
                            "locationName": "Location 13"
                        },
                        {
                            "studyDbId": 4,
                            "studyName": "Ghana Yield Trial MET 2",
                            "locationName": "Location 14"
                        },
                        {
                            "studyDbId": 5,
                            "studyName": "Ghana Yield Trial MET 3",
                            "locationName": "Location 15"
                        }
                    ],
                    "additionalInfo": {
                        "donorName": "Donor2",
                        "collaborator": "NationalPartner1",
                        "fundingUSD": 300000
                    }
                }
            ],
            [
                {
                    "trialDbId": 4,
                    "trialName": "Ghana Yield Trial 1",
                    "programDbId": 3,
                    "name": "Program 3",
                    "startDate": "7/1/2012",
                    "endDate": "2/1/2013",
                    "active": false,
                    "studies": [
                        {
                            "studyDbId": 6,
                            "studyName": "Ghana Yield Trial 1-1",
                            "locationName": "Location 16"
                        }
                    ],
                    "additionalInfo": {
                        "donorName": "Donor1",
                        "specialProject": "Project2"
                    }
                }
            ],
            [
                {
                    "trialDbId": 5,
                    "trialName": "Ghana Yield Trial 2",
                    "programDbId": 3,
                    "name": "Program 3",
                    "startDate": "8/15/2013",
                    "endDate": "2/28/2014",
                    "active": false,
                    "studies": [
                        {
                            "studyDbId": 7,
                            "studyName": "Ghana Yield Trial 2-1",
                            "locationName": "Location 17"
                        }
                    ],
                    "additionalInfo": {

                    }
                }
            ],
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
                    "trialDbId": 7,
                    "trialName": "Mozambique Yield Trial",
                    "programDbId": 4,
                    "name": "Program 4",
                    "startDate": "5/12/2011",
                    "endDate": "11/30/2011",
                    "active": false,
                    "studies": [
                        {
                            "studyDbId": 9,
                            "studyName": "Mozambique Yield Trial",
                            "locationName": "Location 4"
                        }
                    ],
                    "additionalInfo": {
                        "specialProject": "Project2",
                        "fundingUSD": 1000000
                    }
                }
            ],
            [
                {
                    "trialDbId": 8,
                    "trialName": "Mozambique Genotype Trial",
                    "programDbId": 4,
                    "name": "Program 4",
                    "startDate": "2/17/2012",
                    "endDate": "8/21/2012",
                    "active": false,
                    "studies": [
                        {
                            "studyDbId": 10,
                            "studyName": "Mozambique Genotype Trial",
                            "locationName": "Location 5"
                        }
                    ],
                    "additionalInfo": {
                        "donorName": "Donor1",
                        "collaborator": "NationalPartner1"
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
