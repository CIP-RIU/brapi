source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'attributes/categories'")


test_that("Calls are listed.", {
  acall = brapi::attributes_categories(rclass = "list")
  expect_equal(length(acall), 2)
  expect_equal(length(acall$result$data), 3)
})

test_that("Parameters are tested.", {
  acall = brapi::attributes_categories(pageSize = 1)
  expect_equal(nrow(acall), 1)
  acall = brapi::attributes_categories(0, pageSize = 2)
  expect_equal(nrow(acall), 2)
})

}
