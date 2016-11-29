source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the call 'crops'")


test_that("Crops are listed.", {
  expect_equal(length(brapi::crops_list()), 4)
  expect_equal(brapi::crops_list()[1], "cassava")
  expect_equal(brapi::crops_list()[2], "potato")
  expect_equal(brapi::crops_list()[3], "sweetpotato")
  expect_equal(brapi::crops_list()[4], "yam")
})

}
