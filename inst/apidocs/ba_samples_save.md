
## GET [/brapi/v1/samples]


```r
library(brapi)
library(magrittr)
  # make sure brapiTS::mock_server() is running in a separate process

 
   con <- ba_connect() %>% ba_login()
```

```
Authenticated!
```

```r
  sampleData <- list(
    plantId = 1,
    plotId = 1,
    takenBy = "RS",
    sampleDate = "01",
    sampleType = "x",
    tissueType = "tt",
    notes = "notes"
  )

  ba_show_info(TRUE)
  ba_samples_save(con, sampleData)
```

```
URL call was: http://127.0.0.1:2021/brapi/v1/samples/
```

```
Server status: 200 (ok)!
```

```
[1] "Unique-Plant-SampleId-1234567890"
attr(,"class")
[1] "character"  "ba_samples"
```

```r
  ba_show_info(FALSE)
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 6,
            "pageSize": 100
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "data": [
            {
                "programDbId": 1,
                "name": "Program 1",
                "abbreviation": "P1",
                "objective": "Global Population Improvement",
                "leadPerson": "G. Leader"
            },
            {
                "programDbId": 2,
                "name": "Program 2",
                "abbreviation": "P2",
                "objective": "XYZ",
                "leadPerson": "M. Breeder"
            },
            {
                "programDbId": 3,
                "name": "Program 3",
                "abbreviation": "P3",
                "objective": "XYZ",
                "leadPerson": "W. Select"
            },
            {
                "programDbId": 4,
                "name": "Program 4",
                "abbreviation": "P4",
                "objective": "ABC",
                "leadPerson": "G. Gain"
            },
            {
                "programDbId": 5,
                "name": "Program 5",
                "abbreviation": "P5",
                "objective": "Processing",
                "leadPerson": "C. Improvement"
            },
            {
                "programDbId": 6,
                "name": "Program 6",
                "abbreviation": "P6",
                "objective": "Demo",
                "leadPerson": "A. Test"
            }
        ]
    }
}

```


