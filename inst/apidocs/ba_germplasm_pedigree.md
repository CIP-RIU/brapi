
## GET [/brapi/v1/germplasm/{id}/markerprofiles]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_germplasm_pedigree(con, germplasmDbId = "3", rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {

        },
        "status": {

        },
        "datafiles": [

        ]
    },
    "result": {
        "germplasmDbId": 3,
        "pedigree": "A000001 / A000002",
        "parent1Id": 1,
        "parent2Id": 2
    }
}

```


