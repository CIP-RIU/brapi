source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}/pedigree'")


test_that("Calls are listed.", {
  expect_equal(brapi::germplasm_pedigree(), NULL)
})

test_that("Parameters are tested.", {
  expect_equal(length(brapi::germplasm_pedigree(1)$result), 4)
  expect_equal(length(brapi::germplasm_pedigree(5)$result), 4)
  expect_equal(length(brapi::germplasm_pedigree(5, notation = "purdue")$result), 4)
  expect_equal(brapi::germplasm_pedigree(5)$result$pedigree, "landrace")
 })

}
