source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function brapi_db")

test_that("Calls are listed.", {
  expect_equal(class(brapi_db()), "brapi_db_list")
  expect_equal(length(brapi_db()), 2)
  expect_equal(names(brapi_db()[2]), "mockbase")
  expect_equal(length(brapi_db()$mockbase), 5)
})


}
