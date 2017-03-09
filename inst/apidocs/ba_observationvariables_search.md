
## GET [/brapi/v1/variables-search]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_observationvariables_search(con, rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 4,
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
                "scale.validValues.max": "NA",
                "scale.validValues.categories": "",
                "defaultValue": "NA",
                "scale": {

                }
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
            },
            {
                "observationVariableDbId": "MO_123:0100641",
                "name": "Yield",
                "ontologyDbId": "MO_123",
                "ontologyName": "new crop",
                "synonyms": [
                    "Marketable Yield",
                    "Yield I"
                ],
                "contextOfUse": "Trial evaluation",
                "growthStage": "mature",
                "status": "recommended",
                "xref": "TL_455:0003007",
                "institution": "INST1",
                "scientist": "M. Who",
                "date": "8/15/2016",
                "language": "EN",
                "crop": "new crop",
                "trait": {
                    "traitDbId": "CO_334:0100621",
                    "name": "Yield",
                    "class": "agronomic trait",
                    "description": "New crop marketable yield",
                    "synonyms": "Marketable yield",
                    "mainAbbreviation": "YD",
                    "alternativeAbbreviations": [
                        "MYD",
                        "CMYD"
                    ],
                    "entity": "root",
                    "attribute": "",
                    "status": "recommended",
                    "xref": ""
                },
                "method": {

                },
                "scale.validValues.max": 1000,
                "scale.validValues.categories": "",
                "defaultValue": "NA",
                "scale": {
                    "scaleDbId": "CO_334:0100527",
                    "name": "kg",
                    "datatype": "Numeric",
                    "decimalPlaces": 2,
                    "xref": null,
                    "validValues": {
                        "min": 1,
                        "max": 1000,
                        "categories": {

                        }
                    }
                }
            },
            {
                "observationVariableDbId": "MO_123:0100651",
                "name": "Fe",
                "ontologyDbId": "MO_123",
                "ontologyName": "new crop",
                "synonyms": "Iron content",
                "contextOfUse": {

                },
                "growthStage": "mature",
                "status": "recommended",
                "xref": "TL_455:0003008",
                "institution": "INST2",
                "scientist": "K. Mart",
                "date": "1/12/2016",
                "language": "EN",
                "crop": "new crop",
                "trait": {
                    "traitDbId": "CO_334:0100622",
                    "name": "Iron content",
                    "class": "physiological trait",
                    "description": "New crop storage root pulp iron content",
                    "synonyms": {

                    },
                    "mainAbbreviation": "Fe",
                    "alternativeAbbreviations": {

                    },
                    "entity": "root",
                    "attribute": "Fe",
                    "status": "recommended",
                    "xref": ""
                },
                "method": {

                },
                "scale.validValues.max": 2,
                "scale.validValues.categories": "1=low; 2=medium; 3=high",
                "defaultValue": 3,
                "scale": {
                    "scaleDbId": "CO_334:0100528",
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


