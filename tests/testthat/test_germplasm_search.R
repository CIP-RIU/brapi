source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm-search'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::germplasm_search(rclass = "list")), 2)
  expect_equal(length(brapi::germplasm_search(rclass = "list")$result$data), 5)
})

test_that("GET Parameters are tested.", {
  expect_equal(length(brapi::germplasm_search(page = 0, pageSize = 1, rclass = "list")$result$data), 1)
  expect_equal(length(brapi::germplasm_search(germplasmDbId = 1, rclass = "list")$result$data), 1)
  expect_equal(length(brapi::germplasm_search(germplasmName = "Name002", rclass = "list")$result$data), 1)
  expect_equal(length(brapi::germplasm_search(germplasmPUI =
                            "http://data.cipotato.org/accession/A000005", rclass = "list")$result$data), 1)
})

test_that("POST Parameters are tested.", {
  expect_equal(length(brapi::germplasm_search(page = 0, pageSize = 1, rclass = "list", method = "POST")$result$data), 1)
  expect_equal(length(brapi::germplasm_search(germplasmDbId = 1, rclass = "list", method = "POST")$result$data), 1)
  expect_equal(length(brapi::germplasm_search(germplasmName = "Name002", rclass = "list", method = "POST")$result$data), 1)
  expect_equal(length(brapi::germplasm_search(germplasmPUI =
                                                "http://data.cipotato.org/accession/A000005",
                                              rclass = "list"
                                              , method = "POST")$result$data), 1)
})


}
