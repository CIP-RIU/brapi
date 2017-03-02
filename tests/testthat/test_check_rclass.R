source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function check_rclass")

test_that("Parameters are checked.", {
  expect_silent(check_rclass("json"))
  expect_silent(check_rclass("list"))
  expect_silent(check_rclass("data.frame"))
  expect_silent(check_rclass("tibble"))
  expect_silent(check_rclass("vector"))
  expect_error(check_rclass("x"))
  expect_error(check_rclass(0))
  expect_error(check_rclass(TRUE))
})


}
