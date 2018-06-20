context("phenotypes_search")

res <- '{
    "metadata": {
"pagination": {
"totalCount": 17,
"currentPage": 0,
"totalPages": 17,
"pageSize": 1
},
"status": [],
"datafiles": []
},
"result": {
"data": [
{
  "locationDbId": "1",
  "locationType": "Storage location",
  "name": "Location 1",
  "abbreviation": "L1",
  "countryCode": "PER",
  "countryName": "Peru",
  "latitude": -11.1275,
  "longitude": -75.35639,
  "altitude": 828,
  "instituteName": "Plant Science Institute",
  "instituteAddress": "71 Pilgrim Avenue Chevy Chase MD 20815",
  "instituteAdress": "71 Pilgrim Avenue Chevy Chase MD 20815"
}
]
}
}'


test_that(" no additionalInfo works", {
  out <- brapi:::loc2tbl(res, "tibble")
  expect_true(ncol(out) == 10)
  expect_true(nrow(out) == 1)
})


