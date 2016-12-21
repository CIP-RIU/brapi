source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'maps_details'")

test_that("maps_details are listed.", {
  expect_equal(length(maps_details(1, rclass = "list")), 2)
  expect_equal(ncol(maps_details(1)), 3)
  expect_equal(nrow(maps_details(1)), 2)
  expect_equal(nrow(maps_details(2)), 1)
  expect_equal(nrow(maps_details(3)), 3)
})


}
