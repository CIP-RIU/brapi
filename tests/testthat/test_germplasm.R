source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}'")


test_that("Calls are listed.", {
  expect_equal(brapi::germplasm(), NULL)
})

test_that("Parameters are tested.", {
  expect_equal(length(brapi::germplasm(1)$result$data), 1)
  expect_equal(length(brapi::germplasm(5)$result$data), 1)
 })

}
