
## GET [/brapi/v1/germplasm/{id}]

```r
library(brapi)
library(magrittr)

# make sure brapiTS::mock_server() is running in a separate process
con <- ba_connect()

json <- ba_germplasm_details(con, rclass = "json")
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
        "data": [
            {
                "germplasmDbId": 1,
                "defaultDisplayName": "G000001",
                "accessionNumber": "A000001",
                "germplasmName": "Name001",
                "germplasmPUI": "http://data.cipotato.org/accession/A000001",
                "pedigree": "landrace",
                "germplasmSeedSource": "open pollination",
                "synonyms": "landrace 1",
                "commonCropName": "sweetpotato",
                "instituteCode": "PER001",
                "instituteName": "CIP",
                "biologicalStatusOfAccessionCode": 300,
                "countryOfOriginCode": "BRA",
                "typeOfGermplasmStorageCode": 13,
                "genus": "Ipomoea",
                "species": "batatas",
                "speciesAuthority": "L",
                "subtaxa": "",
                "subtaxaAuthority": "",
                "donors": [
                    {
                        "donorAccessionNumber": "BRA001001",
                        "donorInstituteCode": "BRA001",
                        "germplasmPUI": "http://bra/accession/BRA001001"
                    }
                ],
                "acquisitionDate": "19840101"
            },
            {
                "germplasmDbId": 2,
                "defaultDisplayName": "G000002",
                "accessionNumber": "A000002",
                "germplasmName": "Name002",
                "germplasmPUI": "http://data.cipotato.org/accession/A000002",
                "pedigree": "landrace",
                "germplasmSeedSource": "open pollination",
                "synonyms": "landrace 2",
                "commonCropName": "sweetpotato",
                "instituteCode": "PER001",
                "instituteName": "CIP",
                "biologicalStatusOfAccessionCode": 300,
                "countryOfOriginCode": "ECU",
                "typeOfGermplasmStorageCode": 20,
                "genus": "Ipomoea",
                "species": "batatas",
                "speciesAuthority": "L",
                "subtaxa": "",
                "subtaxaAuthority": "",
                "donors": [
                    {
                        "donorAccessionNumber": "ECU001001",
                        "donorInstituteCode": "ECU001",
                        "germplasmPUI": "http://ecu/accession/ECU001001"
                    }
                ],
                "acquisitionDate": "19840101"
            },
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
            },
            {
                "germplasmDbId": 4,
                "defaultDisplayName": "G000004",
                "accessionNumber": "A000004",
                "germplasmName": "Name004",
                "germplasmPUI": "http://data.cipotato.org/accession/A000004",
                "pedigree": "A000002 / A000001",
                "germplasmSeedSource": "A000002/A000001",
                "synonyms": "variety 2",
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
                        "donorAccessionNumber": "A000004",
                        "donorInstituteCode": "PER001",
                        "germplasmPUI": "http://data.cipotato.org/accession/A000004"
                    }
                ],
                "acquisitionDate": "20010101"
            },
            {
                "germplasmDbId": 5,
                "defaultDisplayName": "G000005",
                "accessionNumber": "A000005",
                "germplasmName": "Name005",
                "germplasmPUI": "http://data.cipotato.org/accession/A000005",
                "pedigree": "landrace",
                "germplasmSeedSource": "open pollination",
                "synonyms": "landrace 3",
                "commonCropName": "sweetpotato",
                "instituteCode": "PER001",
                "instituteName": "CIP",
                "biologicalStatusOfAccessionCode": 300,
                "countryOfOriginCode": "ECU",
                "typeOfGermplasmStorageCode": 20,
                "genus": "Ipomoea",
                "species": "batatas",
                "speciesAuthority": "L",
                "subtaxa": "",
                "subtaxaAuthority": "",
                "donors": [
                    {
                        "donorAccessionNumber": "ECU001002",
                        "donorInstituteCode": "ECU002",
                        "germplasmPUI": "http://ecu/accession/ECU001002"
                    },
                    {
                        "donorAccessionNumber": "PER002001",
                        "donorInstituteCode": "PER002",
                        "germplasmPUI": "http://per/accession/PER002001"
                    }
                ],
                "acquisitionDate": "19910101"
            },
            {
                "germplasmDbId": 15,
                "defaultDisplayName": "gG00015",
                "accessionNumber": "A000015",
                "germplasmName": "G15",
                "germplasmPUI": "http://www.crop-diversity.org/mgis/accession/GBA0123",
                "pedigree": "unknown/unknown",
                "germplasmSeedSource": "SS10",
                "synonyms": "Landrace 4",
                "commonCropName": "sweetpotato",
                "instituteCode": "PER001",
                "instituteName": "CIP",
                "biologicalStatusOfAccessionCode": 300,
                "countryOfOriginCode": "PER",
                "typeOfGermplasmStorageCode": 12,
                "genus": "Ipomoea",
                "species": "batatas",
                "speciesAuthority": "L",
                "subtaxa": "",
                "subtaxaAuthority": "",
                "donors": [
                    {
                        "donorAccessionNumber": [

                        ],
                        "donorInstituteCode": [

                        ],
                        "germplasmPUI": [

                        ]
                    }
                ],
                "acquisitionDate": "20010101"
            }
        ]
    }
}

```


