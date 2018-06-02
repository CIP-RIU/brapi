context("genomemaps_data")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_genomemaps_data(con = con, mapDbId = "gm1", linkageGroupName = "1")
  expect_that(nrow(res) == 11, is_true())

})

test_that("Return formats work", {

  res <- ba_genomemaps_data(con = con, mapDbId = "gm1", linkageGroupName = "1", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_genomemaps_data(con = con, mapDbId = "gm1", linkageGroupName = "1", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_genomemaps_data(con = con, mapDbId = "gm1", linkageGroupName = "1", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

  res <- ba_genomemaps_data(con = con, mapDbId = "gm1", linkageGroupName = "1", rclass = "vector")
  expect_that("data.frame" %in% class(res), is_true())

})
