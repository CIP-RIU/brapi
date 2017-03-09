
## GET [/brapi/v1/studies/{studyDbId}/germplasm?pageSize=20&page=1]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_germplasm_details_study(con, studyDbId = "123",rclass = "json")
```

### Response

Code: 200 (application/json)

```json
{
    "metadata": {
        "pagination": {
            "currentPage": 0,
            "pageTotal": 1,
            "totalCount": 3,
            "pageSize": 1000
        },
        "status": [

        ],
        "datafiles": [

        ]
    },
    "result": {
        "studyDbId": "123",
        "trialName": "myBestTrial",
        "data": [
            {
                "germplasmDbId": 382,
                "entryNumber": 1,
                "germplasmName": "Pahang",
                "pedigree": "TOBA97/SW90.1057",
                "seedSource": "SS1",
                "accessionNumber": "ITC0609",
                "germplasmPUI": "http://www.crop-diversity.org/mgis/accession/01BEL084609",
                "synonyms": [
                    "01BEL084609"
                ]
            },
            {
                "germplasmDbId": 394,
                "entryNumber": 2,
                "germplasmName": "Pahang",
                "pedigree": "TOBA97/SW90.1057",
                "seedSource": "SS2",
                "accessionNumber": "ITC0727",
                "germplasmPUI": "http://www.crop-diversity.org/mgis/accession/01BEL084727",
                "synonyms": [
                    "01BEL084727"
                ]
            },
            {
                "germplasmDbId": 378,
                "entryNumber": 3,
                "germplasmName": "Pahang",
                "pedigree": "TOBA97/SW90.1057",
                "seedSource": "SS3",
                "accessionNumber": "ABC0123",
                "germplasmPUI": "http://www.crop-diversity.org/mgis/accession/02ABZY012034",
                "synonyms": [
                    "02ABZY012034",
                    "Bukundi"
                ]
            }
        ]
    }
}

```


