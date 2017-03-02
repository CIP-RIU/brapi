source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function check_paging")

test_that("Parameters are checked.", {
  expect_silent(check_paging(1, 0))
  expect_silent(check_paging(50, 1))
  expect_error(check_paging("x", 1))
  expect_error(check_paging(1, "x"))
  expect_error(check_paging(TRUE, FALSE))
})


}
