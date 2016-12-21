source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function as.brapi_db")

test_that("Calls are listed.", {
  expect_equal(class(as.brapi_db()), "brapi_db")
  expect_equal(length(as.brapi_db()), 5)
})


}
