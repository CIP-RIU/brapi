
## GET [/brapi/v1/studies-search?studyType={studyType}&seasonDbId={seasonDbId}&locationDbId={locationDbId}&programDbId={programDbId}&germplasmDbIds={germplasmDbIds}&observationVariableDbIds={observationVariableDbIds}&pageSize={pageSize}&page={page}&active={active}&sortBy={sortBy}&sortOrder={sortOrder}]

## POST [/brapi/v1/studies-search]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect() 

args(ba_studies_search)
```

```
function (con = NULL, studyType = "any", programDbId = "any", 
    locationDbId = "any", seasonDbId = "any", germplasmDbIds = "any", 
    observationVariableDbIds = "any", active = "any", sortBy = "any", 
    sortOrder = "any", page = 0, pageSize = 1000, rclass = "tibble") 
NULL
```

```r
json <- ba_studies_search(con, rclass = "json")
```

```
Using GET
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 11,
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
                "studyDbId": 1,
                "name": "Peru Yield Trial 1-1",
                "trialDbId": 1,
                "trialName": "Peru Yield Trial 1",
                "studyType": "Yield study",
                "seasons": [
                    "2013 A"
                ],
                "locationDbId": 1,
                "locationName": "Location 1",
                "programDbId": 1,
                "programName": "Program 1",
                "startDate": "1/1/2013",
                "endDate": "7/5/2013",
                "active": false,
                "additionalInfo": {
                    "donorName": "Donor1",
                    "specialProject": "Project1"
                }
            },
            {
                "studyDbId": 2,
                "name": "Peru Yield Trial 2-1",
                "trialDbId": 2,
                "trialName": "Peru Yield Trial 2",
                "studyType": "Yield study",
                "seasons": [
                    "2014 B"
                ],
                "locationDbId": 2,
                "locationName": "Location 2",
                "programDbId": 1,
                "programName": "Program 1",
                "startDate": "6/1/2014",
                "endDate": "1/15/2015",
                "active": false,
                "additionalInfo": {

                }
            },
            {
                "studyDbId": 3,
                "name": "Ghana Yield Trial MET 1",
                "trialDbId": 3,
                "trialName": "Ghana Genotype Trial 1",
                "studyType": "MET study",
                "seasons": [
                    "2011 A",
                    "2012 A"
                ],
                "locationDbId": 13,
                "locationName": "Location 13",
                "programDbId": 2,
                "programName": "Program 2",
                "startDate": "5/1/2011",
                "endDate": "12/15/2011",
                "active": false,
                "additionalInfo": {
                    "donorName": "Donor2",
                    "collaborator": "NationalPartner1",
                    "fundingUSD": 300000
                }
            },
            {
                "studyDbId": 4,
                "name": "Ghana Yield Trial MET 2",
                "trialDbId": 3,
                "trialName": "Ghana Genotype Trial 1",
                "studyType": "MET study",
                "seasons": [
                    "2011 A",
                    "2012 A"
                ],
                "locationDbId": 14,
                "locationName": "Location 14",
                "programDbId": 2,
                "programName": "Program 2",
                "startDate": "5/1/2011",
                "endDate": "12/15/2011",
                "active": false,
                "additionalInfo": {
                    "donorName": "Donor1",
                    "specialProject": "Project2"
                }
            },
            {
                "studyDbId": 5,
                "name": "Ghana Yield Trial MET 3",
                "trialDbId": 3,
                "trialName": "Ghana Genotype Trial 1",
                "studyType": "MET study",
                "seasons": [
                    "2011 A",
                    "2012 A"
                ],
                "locationDbId": 15,
                "locationName": "Location 15",
                "programDbId": 2,
                "programName": "Program 2",
                "startDate": "5/1/2011",
                "endDate": "12/15/2011",
                "active": false,
                "additionalInfo": {

                }
            },
            {
                "studyDbId": 6,
                "name": "Ghana Yield Trial 1-1",
                "trialDbId": 4,
                "trialName": "Ghana Yield Trial 1",
                "studyType": "Yield study",
                "seasons": [
                    "2012 B"
                ],
                "locationDbId": 16,
                "locationName": "Location 16",
                "programDbId": 3,
                "programName": "Program 3",
                "startDate": "7/1/2012",
                "endDate": "2/1/2013",
                "active": false,
                "additionalInfo": {

                }
            },
            {
                "studyDbId": 7,
                "name": "Ghana Yield Trial 2-1",
                "trialDbId": 5,
                "trialName": "Ghana Yield Trial 2",
                "studyType": "Yield study",
                "seasons": [
                    "2013 A"
                ],
                "locationDbId": 17,
                "locationName": "Location 17",
                "programDbId": 3,
                "programName": "Program 3",
                "startDate": "8/15/2013",
                "endDate": "2/28/2014",
                "active": false,
                "additionalInfo": {
                    "specialProject": "Project2",
                    "fundingUSD": 1000000
                }
            },
            {
                "studyDbId": 8,
                "name": "Ghana Yield Trial 3-1",
                "trialDbId": 6,
                "trialName": "Ghana Yield Trial 3",
                "studyType": "Yield study",
                "seasons": [
                    "2014 B"
                ],
                "locationDbId": 16,
                "locationName": "Location 16",
                "programDbId": 3,
                "programName": "Program 3",
                "startDate": "9/22/2014",
                "endDate": "3/21/2015",
                "active": true,
                "additionalInfo": {
                    "donorName": "Donor1",
                    "collaborator": "NationalPartner1"
                }
            },
            {
                "studyDbId": 9,
                "name": "Mozambique Yield Trial",
                "trialDbId": 7,
                "trialName": "Mozambique Yield Trial",
                "studyType": "Yield study",
                "seasons": [
                    "2011 A"
                ],
                "locationDbId": 4,
                "locationName": "Location 4",
                "programDbId": 4,
                "programName": "Program 4",
                "startDate": "5/12/2011",
                "endDate": "11/30/2011",
                "active": false,
                "additionalInfo": {
                    "specialProject": "Project1",
                    "fundingUSD": 500000
                }
            },
            {
                "studyDbId": 10,
                "name": "Mozambique Genotype Trial",
                "trialDbId": 8,
                "trialName": "Mozambique Genotype Trial",
                "studyType": "Yield study",
                "seasons": [
                    "2012 B"
                ],
                "locationDbId": 5,
                "locationName": "Location 5",
                "programDbId": 4,
                "programName": "Program 4",
                "startDate": "2/17/2012",
                "endDate": "8/21/2012",
                "active": false,
                "additionalInfo": {

                }
            },
            {
                "studyDbId": 11,
                "name": "Demo Yield Trial",
                "trialDbId": 9,
                "trialName": "Demo Yield Trial",
                "studyType": "Yield study",
                "seasons": [
                    "2016 A"
                ],
                "locationDbId": 3,
                "locationName": "Location 3",
                "programDbId": 6,
                "programName": "Program 6",
                "startDate": "3/24/2016",
                "endDate": "10/21/2016",
                "active": true,
                "additionalInfo": {

                }
            }
        ]
    }
}

```


