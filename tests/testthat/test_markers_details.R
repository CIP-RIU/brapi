source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'markers/id'")

  con <- connect(secure = FALSE)

test_that("Markers are listed.", {
  expect_equal(nrow(markers_details(con, 1)), 1)
  expect_equal(ncol(markers_details(con, 1)), 6)
})

test_that("Calls parameters work.", {
  expect_equal(class(markers_details(con, 1, "tibble"))[1], "tbl_df")
  expect_equal( (class(markers_details(con, 1, "data.frame")))[1], "data.frame")
  expect_equal(class(markers_details(con, 1, "list"))[1], "list")
  expect_equal("json" %in% class(markers_details(con, 1, "json")), TRUE)
  expect_equal("brapi_markers_details" %in% class(markers_details(con, 1)), TRUE)
})



}
