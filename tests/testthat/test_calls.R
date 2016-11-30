source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the call 'calls'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::calls()), 42)

})

}
