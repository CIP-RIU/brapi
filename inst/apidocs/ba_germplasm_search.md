
## GET [/brapi/v1/germplasm-search?germplasmName={germplasmName}&germplasmDbId={germplasmDdId}&germplasmPUI={germplasmPUI}&pageSize={pageSize}&page={page}]


```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_germplasm_search(con, germplasmDbId = "3", rclass = "json")
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
                "germplasmDbId": 3,
                "defaultDisplayName": "G000003",
                "accessionNumber": "A000003",
                "germplasmName": "Name003",
                "germplasmPUI": "http://data.cipotato.org/accession/A000003",
                "pedigree": "A000001 / A000002",
                "germplasmSeedSource": "A000001/A000002",
                "synonyms": "variety 1",
                "commonCropName": "sweetpotato",
                "instituteCode": "PER001",
                "instituteName": "CIP",
                "biologicalStatusOfAccessionCode": 500,
                "countryOfOriginCode": "PER",
                "typeOfGermplasmStorageCode": 12,
                "genus": "Ipomoea",
                "species": "batatas",
                "speciesAuthority": "L",
                "subtaxa": "",
                "subtaxaAuthority": "",
                "donors": [
                    {
                        "donorAccessionNumber": "A000003",
                        "donorInstituteCode": "PER001",
                        "germplasmPUI": "http://data.cipotato.org/accession/A000003"
                    }
                ],
                "acquisitionDate": "20010101"
            }
        ]
    }
}

```


