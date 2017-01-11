source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'maps_positions_range'")
  con = connect(secure = FALSE)

test_that("maps_range are listed.", {
  expect_equal(length(genomemaps_data_range(con, 1, 1, rclass = "list")), 2)
  expect_equal(ncol(genomemaps_data_range(con, 1, 1)), 3)

})

test_that("map parameters work.", {
  expect_equal(nrow(genomemaps_data_range(con, 1, 1 )), 5)
  expect_equal(nrow(genomemaps_data_range(con, 1, 1, 25, 45)), 2)
})

test_that("map paging work.", {
  expect_equal(nrow(genomemaps_data_range(con,1, 1, pageSize = 1)), 1)
  expect_equal(nrow(genomemaps_data_range(con,1, 1, pageSize = 1, page = 2)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(genomemaps_data_range(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(genomemaps_data_range(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(genomemaps_data_range(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(genomemaps_data_range(con, rclass = "data.frame")), TRUE)
  expect_equal("brapi_genomemaps_data_range" %in% class(genomemaps_data_range(con )), TRUE)
})


}
