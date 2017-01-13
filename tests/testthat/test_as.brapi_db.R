
if (check_server_status == 200) {

context("Testing the helper function as.brapi_db")

test_that("Calls are listed.", {
  expect_equal("brapi_db" %in% class(as.brapi_db()), TRUE)
  expect_equal(length(as.brapi_db()), 13)
})


}
