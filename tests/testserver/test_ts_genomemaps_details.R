context("ts genomemaps_details")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_genomemaps_details(con = con, mapDbId = "gm1")
  expect_that(nrow(res) == 3, is_true())

})

test_that("Return formats work", {

  res <- ba_genomemaps_details(con = con, mapDbId = "gm1", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_genomemaps_details(con = con, mapDbId = "gm1", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_genomemaps_details(con = con, mapDbId = "gm1", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})
