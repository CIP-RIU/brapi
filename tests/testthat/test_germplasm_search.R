source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm-search'")

  con <- ba_connect(secure = FALSE)

test_that("Calls are listed.", {
  expect_equal(length(ba_germplasm_search(con, rclass = "list")), 2)
  expect_equal(length(ba_germplasm_search(con, rclass = "list")$result$data), 9)
})

test_that("GET Parameters are tested.", {
  expect_equal(length(ba_germplasm_search(con, page = 0, pageSize = 1, rclass = "list")$result$data), 1)
  expect_equal(length(ba_germplasm_search(con, germplasmDbId = "1", rclass = "list")$result$data), 1)
  expect_equal(length(ba_germplasm_search(con, germplasmName = "Name002", rclass = "list")$result$data), 1)
  # expect_equal(length(ba_germplasm_search(con, germplasmPUI =
  #                           "http://data.cipotato.org/accession/A000005", rclass = "list")$result$data), 1)
})

test_that("POST Parameters are tested.", {
  expect_equal(length(ba_germplasm_search(con, page = 0, pageSize = 1, rclass = "list",
                                       method = "POST")$result$data), 1)
  expect_equal(length(ba_germplasm_search(con, germplasmDbId = "1", rclass = "list",
                                       method = "POST")$result$data), 1)
  expect_equal(length(ba_germplasm_search(con, germplasmName = "Name002", rclass = "list",
                                       method = "POST")$result$data), 1)
#   expect_equal(length(ba_germplasm_search(con, germplasmPUI =
#                                                 "http://data.cipotato.org/accession/A000005",
#                                               rclass = "list"
#                                               , method = "POST")$result$data), 1)
 })


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_germplasm_search(con,  rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_germplasm_search(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_germplasm_search(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_germplasm_search(con, rclass = "data.frame")), TRUE)
  expect_equal("ba_germplasm_search" %in% class(ba_germplasm_search(con)), TRUE)
})


}
