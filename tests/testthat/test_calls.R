source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'calls'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::calls()), 2)
  expect_equal(length(brapi::calls()$result$data), 43)
  expect_equal(length(brapi::calls("text")$result$data), 1)
  expect_equal(length(brapi::calls("json")$result$data), 43)
})

}
