context("germplasm_details")

con <- ba_db()$sweetpotatobase

test_that("Germplasm_details results are present", {

  res <- ba_germplasm_details(con = con)
  expect_that(ncol(res) == 0, is_true())

})

test_that("Germplasm_details results are present", {

  res <- ba_germplasm_details(con = con, germplasmDbId = "55767")
  expect_that(nrow(res) == 1, is_true())

})
