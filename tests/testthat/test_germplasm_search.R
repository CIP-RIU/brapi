source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm-search'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::germplasm_search()), 2)
  expect_equal(length(brapi::germplasm_search()$result$data), 5)
})

test_that("Parameters are tested.", {
  expect_equal(length(brapi::germplasm_search(page = 0, pageSize = 1)$result$data), 1)
  expect_equal(length(brapi::germplasm_search(germplasmDbId = 1)$result$data), 1)
  expect_equal(length(brapi::germplasm_search(germplasmName = "Name002")$result$data), 1)
  expect_equal(length(brapi::germplasm_search(germplasmPUI =
                            "http://data.cipotato.org/accession/A000005")$result$data), 1)
})

}
