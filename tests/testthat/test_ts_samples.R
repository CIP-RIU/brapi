context("ts samples")

con <- ba_db()$testserver

test_that("Samples are present", {

  res <- ba_samples(con = con, sampleDbId = "sam1")
  expect_true( nrow(res) == 1 )

})

test_that("Samples output formats work", {

  res <- ba_samples(con = con, sampleDbId = "sam1", rclass = "json")
  expect_that("json" %in% class(res), is_true())

})
