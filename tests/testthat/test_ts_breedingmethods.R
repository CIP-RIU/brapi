context("ts germplasm breedingmethods")
#testthat::skip_on_cran()

con <- ba_db()$testserver

test_that(" ts germplasm breedingmethods are present", {

  res <- ba_germplasm_breedingmethods(con = con, pageSize = 100)
  expect_true(nrow(res) >= 2)
  expect_true(length(attr(res, "metadata")) == 3)

})

test_that("germplasm breedingmethods output formats work", {

  res <- ba_germplasm_breedingmethods(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

