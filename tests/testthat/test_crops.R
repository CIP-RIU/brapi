source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'crops'")


test_that("Crops are listed.", {
  expect_equal(length(brapi::crops()), 4)
  expect_equal(brapi::crops()[1], "cassava")
  expect_equal(brapi::crops()[2], "potato")
  expect_equal(brapi::crops()[3], "sweetpotato")
  expect_equal(brapi::crops()[4], "yam")
})

test_that("Crop format is used.", {
  expect_equal(length(brapi::crops(format = "json")), 2)
  expect_equal(brapi::crops(format = "json")$result$data[1], "cassava")
  expect_equal(brapi::crops(format = "plain")[1], "cassava")
})


}
