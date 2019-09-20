context("ts samples")

con <- ba_db()$testserver

test_that("Samples are present", {

  res <- ba_samples(con = con, sampleDbId = "sam01")
  expect_true( nrow(res) >= 1 )

})

test_that("Samples output formats work", {

  res <- ba_samples(con = con, sampleDbId = "sam01", rclass = "json")
  expect_that("json" %in% class(res), is_true())

})
