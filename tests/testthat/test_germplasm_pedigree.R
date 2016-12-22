source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}/pedigree'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::germplasm_pedigree(rclass = "list")), 2)
})

test_that("Parameters are tested.", {
  expect_equal(length(brapi::germplasm_pedigree(1, rclass = "list")$result), 4)
  expect_equal(length(brapi::germplasm_pedigree(5, rclass = "list")$result), 4)
  expect_equal(length(brapi::germplasm_pedigree(5, notation = "purdue", rclass = "list")$result), 4)
  expect_equal(brapi::germplasm_pedigree(5, rclass = "list")$result$pedigree, "landrace")
  expect_equal(brapi::germplasm_pedigree(3, rclass = "list")$result$parent1Id, 1)
  expect_equal(brapi::germplasm_pedigree(3, rclass = "list")$result$parent2Id, 2)

  expect_equal(nrow(germplasm_pedigree(3, rclass = "tibble")), 1)
  expect_equal(ncol(germplasm_pedigree(3, rclass = "data.frame")), 4)
 })

}
