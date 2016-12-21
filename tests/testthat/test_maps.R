source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'maps'")

test_that("maps are listed.", {
  expect_equal(length(maps(rclass = "list")), 2)
  expect_equal(ncol(maps()), 9)
  expect_equal(nrow(maps()), 3)
})

test_that("map parameters work.", {
  expect_equal(nrow(maps(species = "batatas")), 2)
  expect_equal(nrow(maps(type = "Physical")), 1)
})

test_that("map paging work.", {
  expect_equal(nrow(maps(pageSize = 1)), 1)
  expect_equal(nrow(maps(pageSize = 1, page = 2)), 1)
})


}
