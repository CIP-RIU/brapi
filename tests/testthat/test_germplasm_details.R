context("germplasm_details")

con <- ba_db()$testserver

test_that("Germplasm_details results are present", {

  res <- ba_germplasm_details(con = con, germplasmDbId = "1")
  expect_that(nrow(res) == 4, is_true())

})
