context("germplasm_markerprofiles")

con <- ba_db()$testserver

test_that(" are present", {

  res <- ba_germplasm_markerprofiles(con = con, germplasmDbId = "1")
  expect_that(nrow(res) >= 2, is_true())

})


