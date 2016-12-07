source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::germplasm(rclass = "list")), 2)
})

test_that("Parameters are tested.", {
  expect_equal(length(brapi::germplasm(1, rclass = "list")$result$data), 1)
  expect_equal(length(brapi::germplasm(5, rclass = "list")$result$data), 1)
 })

}
