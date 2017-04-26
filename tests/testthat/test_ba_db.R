source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function ba_db")

test_that("Calls are listed.", {
  expect_equal("ba_db_list" %in% class(ba_db()), TRUE)
  expect_equal(length(ba_db()), 14)
  expect_equal(names(ba_db()[8]), "mockbase")
  expect_equal(length(ba_db()$mockbase), 15)
})


}
