
## GET  [/brapi/v1/variables/{observationVariableDbId}]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_observationvariables_details(con, rclass = "json")
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
            "pageSize": 10000
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
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
                "scale.validValues.max": 2,
                "scale.validValues.categories": "1=low; 2=medium; 3=high",
                "defaultValue": 2,
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
                }
            }
        ]
    }
}

```


