context("sp samples")

con <- ba_db()$sweetpotatobase

test_that("Samples are present", {

  skip("Not implemented.")

  res <- ba_samples(con = con, sampleDbId = "sam1")
  expect_true( nrow(res) == 1 )

})

test_that("Samples output formats work", {

  skip("Not implemented.")

  res <- ba_samples(con = con, sampleDbId = "sam1", rclass = "json")
  expect_that("json" %in% class(res), is_true())

})
