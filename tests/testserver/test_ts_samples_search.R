context("ts samples_search")

con <- ba_db()$testserver

test_that("Samples are present", {

  res <- ba_samples_search(con = con)
  expect_true( nrow(res) >= 3 )

  res <- ba_samples_search(con = con, sampleDbId = "sam01")
  expect_true( nrow(res) == 1 )

  res <- ba_samples_search(con = con, observationUnitDbId = "1")
  expect_true( nrow(res) == 6 )

  res <- ba_samples_search(con = con, plateDbId = "pl1")
  expect_true( nrow(res) == 16 )

  res <- ba_samples_search(con = con, germplasmDbId = "1")
  expect_true( nrow(res) >= 2 )

  res <- ba_samples_search(con = con, germplasmDbId = "1", pageSize = 1)
  expect_true( nrow(res) >= 1 )

})

test_that("Samples output formats work", {

  res <- ba_samples_search(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

})
