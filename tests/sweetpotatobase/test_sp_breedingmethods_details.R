context("ts germplasm breedingmethods details")
#testthat::skip_on_cran()

con <- ba_db()$sweetpotatobase

test_that("germplasm breedingmethods details are present", {

  skip("Not yet implemented by sweetpotatobase")
  res <- ba_germplasm_breedingmethods_details(con = con, breedingMethodDbId = "bm1")
  expect_true(nrow(res) == 1)
  expect_true(length(attr(res, "metadata")) == 3)

})

test_that("germplasm breedingmethods details output formats work", {

  skip("Not yet implemented by sweetpotatobase")
  res <- ba_germplasm_breedingmethods_details(con = con, breedingMethodDbId = "bm1", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

