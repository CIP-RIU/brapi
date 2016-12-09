source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}/attributes/?attributeList'")


test_that("Calls are listed.", {
  acall = brapi::germplasm_attributes(rclass = "list")
  expect_equal(length(acall), 2)
  expect_equal(length(acall$result$data), 1)
})

test_that("Parameters are tested.", {
  acall = brapi::germplasm_attributes(pageSize = 1)
  expect_equal(nrow(acall), 1)
  acall = brapi::germplasm_attributes(0, pageSize = 2)
  expect_equal(nrow(acall), 2)
})

}
