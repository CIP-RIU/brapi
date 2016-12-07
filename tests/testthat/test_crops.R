source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'crops'")


test_that("Crops are listed.", {
  expect_equal(length(crops(rclass = "list")), 2)
  expect_equal(crops(rclass = "vector")[1], "cassava")
  expect_equal(crops(rclass = "vector")[2], "potato")
  expect_equal(crops(rclass = "vector")[3], "sweetpotato")
  expect_equal(crops(rclass = "vector")[4], "yam")
})

test_that("Crop format is used.", {
  expect_equal(length(brapi::crops(rclass = "list")), 2)
  expect_equal(brapi::crops(rclass = "list")$result$data[[1]][1], "cassava")

})


}
