source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'maps'")

test_that("maps are listed.", {
  expect_equal(length(maps(rclass = "list")), 2)
  expect_equal(ncol(maps()), 9)
  expect_equal(nrow(maps()), 3)
})

}
