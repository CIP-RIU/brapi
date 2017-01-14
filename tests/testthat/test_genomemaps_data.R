source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'maps/positions'")

  con <- connect(secure = FALSE)

test_that("maps_range are listed.", {
  expect_equal(length(genomemaps_data(con, 1, 1, rclass = "list")), 2)
  expect_equal(ncol(genomemaps_data(con, 1, 1)), 4)
})

test_that("map parameters work.", {
  expect_equal(nrow(genomemaps_data(con, 1, 1)), 5)
  expect_equal(nrow(genomemaps_data(con, 1, c(1, 2))), 10)
})

test_that("map paging work.", {
  expect_equal(nrow(genomemaps_data(con, 1, 1, pageSize = 1)), 1)
  expect_equal(nrow(genomemaps_data(con, 1, 1, pageSize = 1, page = 2)), 1)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(genomemaps_data(con, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(genomemaps_data(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(genomemaps_data(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(genomemaps_data(con, rclass = "data.frame")), TRUE)
  expect_equal("brapi_genomemaps_data" %in% class(genomemaps_data(con )), TRUE)
})


}
