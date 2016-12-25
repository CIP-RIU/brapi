source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'markers'")

test_that("Markers are listed.", {
  expect_equal(nrow(markers(1)), 1)
  expect_equal(ncol(markers(1)), 6)
})

test_that("Calls parameters work.", {
  expect_equal(class(markers(1, "tibble"))[1], "tbl_df")
  expect_equal((class(markers(1, "data.frame")))[1], "data.frame")
  expect_equal(class(markers(1, "list"))[1], "list")
  expect_equal(class(markers(1, "json")), "json")
})

}
