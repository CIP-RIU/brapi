

# '/<apipath>/<crop>/brapi/v1/calls'

```r
json <- ba_calls(con, rclass = "json")
```

# JSON
```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 44,
            "pageSize": 50
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "call": "token",
                "datatypes": [
                    [
                        "json",
                        "text"
                    ]
                ],
                "methods": [
                    [
                        "POST",
                        "DELETE"
                    ]
                ]
            },
            {
                "call": "calls",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "crops",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "maps",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "maps/<id>/positions",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "maps/<id>/positions/<id>",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "maps/<id>",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "germplasm/<id>",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studies/<id>/germplasm",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "germplasm/<id>/markerprofiles",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "germplasm/<id>/pedigree",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "germplasm-search",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "germplasm-search",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "POST"
                ]
            },
            {
                "call": "attributes",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "attributes/categories",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "germplasm/<id>/attributes/",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "locations",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "allelematrix-search",
                "datatypes": [
                    [
                        "json",
                        "csv",
                        "tsv"
                    ]
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "allelematrix-search",
                "datatypes": [
                    [
                        "json",
                        "csv",
                        "tsv"
                    ]
                ],
                "methods": [
                    "POST"
                ]
            },
            {
                "call": "markerprofiles/<id>",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "markerprofiles-search",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "POST"
                ]
            },
            {
                "call": "markerprofiles",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "markers/<id>",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "markers",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "variables",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "variables/datatypes",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "variables/<id>",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "ontologies",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "programs",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studies/<id>",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "observationLevels",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studies/<id>/observations",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studies/<id>/observationunits",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studies/<id>/observationVariables",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studies-search",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studies-search",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "POST"
                ]
            },
            {
                "call": "seasons",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studyTypes",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studies/<id>/table",
                "datatypes": [
                    [
                        "json",
                        "csv",
                        "tsv"
                    ]
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "studies/<id>/layout",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "traits",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "traits/<id>",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "trials",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            },
            {
                "call": "trials/<id>",
                "datatypes": [
                    "json"
                ],
                "methods": [
                    "GET"
                ]
            }
        ]
    }
}

```
