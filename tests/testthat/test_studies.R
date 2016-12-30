source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id'")

test_that("Studies are listed.", {
  expect_equal(length(studies(1, rclass = "list")), 2)
  expect_equal(nrow(studies(1, rclass = "data.frame")), 2)
  expect_equal(nrow(studies(1, rclass = "tibble")), 2)
})


test_that("With varying numbers of contacts", {
  expect_equal(nrow(studies(1)), 2)
  expect_equal(ncol(studies(1)), 36)
  expect_equal(nrow(studies(11)), 1)
  expect_equal(ncol(studies(11)), 22)
})




}

