source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'maps_positions'")

test_that("maps_positions are listed.", {
  expect_equal(length(maps_positions(1, rclass = "list")), 2)
  expect_equal(ncol(maps_positions(1, 1)), 4)
})

test_that("map parameters work.", {
  expect_equal(nrow(maps_positions(1, 1)), 5)
  expect_equal(nrow(maps_positions(1, c(1,2))), 10)
})

test_that("map paging work.", {
  expect_equal(nrow(maps_positions(1, 1, pageSize = 1)), 1)
  expect_equal(nrow(maps_positions(1, 1, pageSize = 1, page = 2)), 1)
})


}
