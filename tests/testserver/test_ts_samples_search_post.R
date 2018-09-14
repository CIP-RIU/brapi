context("ts samples_search_post")

con <- ba_db()$testserver

# TODO revise POST call: does not yet filter

test_that("Samples are present", {

  res <- ba_samples_search_post(con = con)
  expect_true( nrow(res) >= 3 )

  res <- ba_samples_search_post(con = con, sampleDbId = "sam1")
  expect_true( nrow(res) == 3 )

  res <- ba_samples_search_post(con = con, observationUnitDbId = "1")
  expect_true( nrow(res) == 3 )

  res <- ba_samples_search_post(con = con, plateDbId = "pl1")
  expect_true( nrow(res) == 3 )

  res <- ba_samples_search_post(con = con, germplasmDbId = "1")
  expect_true( nrow(res) == 3 )

  res <- ba_samples_search_post(con = con, germplasmDbId = "1", pageSize = 1)
  expect_true( nrow(res) == 3 )

})

test_that("Samples output formats work", {

  res <- ba_samples_search_post(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

})
