source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'maps_details'")

  con <- ba_connect(secure = FALSE)

test_that("maps_details are listed.", {
  expect_equal(length(ba_genomemaps_details(con, "1", rclass = "list")), 2)
  expect_equal(ncol(ba_genomemaps_details(con, "1")), 3)
  expect_equal(nrow(ba_genomemaps_details(con, "1")), 2)
  expect_equal(nrow(ba_genomemaps_details(con, "2")), 1)
  expect_equal(nrow(ba_genomemaps_details(con, "3")), 3)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_genomemaps_details(con, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_genomemaps_details(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_genomemaps_details(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_genomemaps_details(con, rclass = "data.frame")), TRUE)
  expect_equal("ba_genomemaps_details" %in% class(ba_genomemaps_details(con )), TRUE)
})


}
