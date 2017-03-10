
## GET [/brapi/v1/studies/{studyDbId}/table]


```r
library(brapi)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect() 

args(ba_studies_table)
```

```
function (con = NULL, studyDbId = "1", format = "json", rclass = "tibble") 
NULL
```

```r
json <- ba_studies_table(con, rclass = "json")
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
        "headerRow": [
            "year",
            "studyDbId",
            "studyName",
            "locationDbId",
            "locationName",
            "germplasmDbId",
            "germplasmName",
            "observationUnitDbID",
            "plotNumber",
            "replicate",
            "blockNumber",
            "observationTimestamp",
            "entryType",
            "X",
            "Y"
        ],
        "observationVariableDbIds": [
            "variable1Id",
            "variable2Id",
            "variable3Id"
        ],
        "observationVariableNames": [
            "plant height",
            "fruit weight",
            "root weight"
        ],
        "data": [
            [
                "2013",
                "1",
                "Peru Yield Trial 1-1",
                "1",
                "Location 1",
                "1",
                "gpName1",
                "gpName1_loc1_plot01",
                "plot01",
                "1",
                "1",
                "7/1/2014 12:12",
                "test",
                "1",
                "1",
                "60",
                "3",
                "123"
            ],
            [
                "2013",
                "1",
                "Peru Yield Trial 1-1",
                "1",
                "Location 1",
                "2",
                "gpName2",
                "gpName2_loc1_plot02",
                "plot02",
                "1",
                "1",
                "7/1/2014 12:13",
                "test",
                "1",
                "2",
                "40",
                "2",
                "213"
            ],
            [
                "2013",
                "1",
                "Peru Yield Trial 1-1",
                "1",
                "Location 1",
                "3",
                "gpName3",
                "gpName3_loc1_plot02",
                "plot03",
                "1",
                "1",
                "7/1/2014 12:14",
                "test",
                "1",
                "3",
                "45",
                "1",
                "145"
            ],
            [
                "2013",
                "1",
                "Peru Yield Trial 1-1",
                "1",
                "Location 1",
                "4",
                "gpName4",
                "gpName4_loc1_plot03",
                "plot04",
                "1",
                "1",
                "7/1/2014 12:15",
                "test",
                "1",
                "4",
                "55",
                "3",
                "254"
            ],
            [
                "2013",
                "1",
                "Peru Yield Trial 1-1",
                "1",
                "Location 1",
                "1",
                "gpName1",
                "gpName1_loc1_plot05",
                "plot05",
                "2",
                "1",
                "7/1/2014 12:16",
                "test",
                "2",
                "1",
                "43",
                "2",
                "167"
            ],
            [
                "2013",
                "1",
                "Peru Yield Trial 1-1",
                "1",
                "Location 1",
                "2",
                "gpName2",
                "gpName2_loc1_plot06",
                "plot06",
                "2",
                "1",
                "7/1/2014 12:17",
                "test",
                "2",
                "2",
                "54",
                "3",
                "198"
            ],
            [
                "2013",
                "1",
                "Peru Yield Trial 1-1",
                "1",
                "Location 1",
                "3",
                "gpName3",
                "gpName3_loc1_plot07",
                "plot07",
                "2",
                "1",
                "7/1/2014 12:18",
                "test",
                "2",
                "3",
                "36",
                "4",
                "204"
            ],
            [
                "2013",
                "1",
                "Peru Yield Trial 1-1",
                "1",
                "Location 1",
                "4",
                "gpName4",
                "gpName4_loc1_plot08",
                "plot08",
                "2",
                "1",
                "7/1/2014 12:19",
                "test",
                "2",
                "4",
                "48",
                "1",
                "296"
            ]
        ]
    }
}

```


