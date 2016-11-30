source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the call 'crops'")


test_that("Crops are listed.", {
  expect_equal(length(brapi::crops()), 4)
  expect_equal(brapi::crops()[1], "cassava")
  expect_equal(brapi::crops()[2], "potato")
  expect_equal(brapi::crops()[3], "sweetpotato")
  expect_equal(brapi::crops()[4], "yam")
})

}
