context("genomemaps_data_range")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_genomemaps_data_range(con = con, mapDbId = "gm1", linkageGroupName = "1",
                                  min = 1050, max = 1080)
  expect_that(nrow(res) == 4, is_true())

})

test_that("Return formats work", {

  res <- ba_genomemaps_data_range(con = con, mapDbId = "gm1", linkageGroupName = "1",
                                  min = 1050, max = 1080, rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_genomemaps_data_range(con = con, mapDbId = "gm1", linkageGroupName = "1",
                                  min = 1050, max = 1080, rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_genomemaps_data_range(con = con, mapDbId = "gm1", linkageGroupName = "1",
                                  min = 1050, max = 1080, rclass = "vector")
  expect_that("tbl_df" %in% class(res), is_true())

})

test_that("Parameters work", {

  res <- ba_genomemaps_data_range(con = con, mapDbId = "gm1", linkageGroupName = "1",
                                  min = 1050, max = 1080, rclass = "json", pageSize = 11000)
  expect_that("json" %in% class(res), is_true())

})

