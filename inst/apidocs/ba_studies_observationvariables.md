
## GET [/brapi/v1/studies/{studyDbId}/observationVariables]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect() 

json <- ba_studies_observationvariables(con, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "pageSize": 0,
            "currentPage": 0,
            "totalCount": 0,
            "totalPages": 0
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "studyDbId": "1",
        "trialName": "myBestTrial",
        "data": [
            {
                "observationVariableDbId": "MO_123:0100631",
                "name": "CT_M_C",
                "ontologyDbId": "MO_123",
                "ontologyName": "new crop",
                "synonyms": {

                },
                "contextOfUse": {

                },
                "growthStage": "",
                "status": "",
                "xref": "",
                "institution": "",
                "scientist": "",
                "date": "",
                "language": "",
                "crop": "",
                "trait": {
                    "traitDbId": "CO_334:0100630",
                    "name": "Canopy temperature",
                    "class": "",
                    "description": "",
                    "synonyms": {

                    },
                    "mainAbbreviation": "",
                    "alternativeAbbreviations": {

                    },
                    "entity": "",
                    "attribute": "",
                    "status": "",
                    "xref": ""
                },
                "method": {

                },
                "scale": {

                },
                "defaultValue": "NA"
            },
            {
                "observationVariableDbId": "MO_123:0100621",
                "name": "caro_spectro",
                "ontologyDbId": "MO_123",
                "ontologyName": "new crop",
                "synonyms": "Carotenoid content by spectro",
                "contextOfUse": [
                    "Trial evaluation",
                    "Nursery evaluation"
                ],
                "growthStage": "mature",
                "status": "recommended",
                "xref": "TL_455:0003001",
                "institution": "",
                "scientist": "",
                "date": "5/13/2016",
                "language": "EN",
                "crop": "new crop",
                "trait": {
                    "traitDbId": "CO_334:0100620",
                    "name": "Carotenoid content",
                    "class": "physiological trait",
                    "description": "New crop storage root pulp carotenoid content",
                    "synonyms": "carotenoid content measure",
                    "mainAbbreviation": "CC",
                    "alternativeAbbreviations": "CCS",
                    "entity": "root",
                    "attribute": "carotenoid",
                    "status": "recommended",
                    "xref": "TL_455:0003023"
                },
                "method": {
                    "methodDbId": "CO_334:0010320",
                    "name": "Visual Rating:total carotenoid by chart_method",
                    "class": "Estimation",
                    "description": "Assessment of the level of yellowness in cassava storage root pulp using the tc chart",
                    "formula": null,
                    "reference": null
                },
                "scale": {
                    "scaleDbId": "CO_334:0100526",
                    "name": "ug/g",
                    "datatype": "Numeric",
                    "decimalPlaces": 0,
                    "xref": null,
                    "validValues": {
                        "min": 1,
                        "max": 2,
                        "categories": [
                            "1=low",
                            "2=medium",
                            "3=high"
                        ]
                    }
                },
                "defaultValue": 2
            }
        ]
    }
}

```


