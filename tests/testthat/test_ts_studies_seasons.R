context("studies_seasons")

con <- ba_db()$testserver

test_that("Studies_seasons are present", {

  res <- ba_studies_seasons(con = con)
  expect_that( nrow(res) > 0, is_true())

})


test_that("Output is transformed", {

  res <- ba_studies_seasons(con = con, rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
