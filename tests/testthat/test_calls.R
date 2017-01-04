source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'calls'")

test_that("Calls are listed.", {
  expect_equal(length(calls(rclass = "list")), 2)
  expect_equal(ncol(calls()), 3)
})

test_that("Calls are listed.", {
  expect_equal(length(calls(rclass = "list")), 2)
  expect_equal(ncol(calls()), 3)
})

test_that("Calls parameters work.", {
  expect_equal(nrow(calls(datatypes = "json")), 31)

  expect_equal(nrow(calls(datatypes = "csv")), 1)

})

}
