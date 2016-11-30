source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the call 'calls'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::calls()), 2)
  expect_equal(length(brapi::calls()$result$data), 42)
  expect_equal(length(brapi::calls("text")$result$data), 1)
})

}
