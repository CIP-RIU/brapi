source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function brapi_db")

test_that("Calls are listed.", {
  expect_equal("brapi_db_list" %in% class(brapi_db()), TRUE)
  expect_equal(length(brapi_db()), 11)
  expect_equal(names(brapi_db()[5]), "mockbase")
  expect_equal(length(brapi_db()$mockbase), 15)
})


}
