source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}/pedigree'")

  con <- connect(secure = FALSE)

test_that("Calls are listed.", {
  expect_equal(length(germplasm_pedigree(con, rclass = "list")), 2)
})

test_that("Parameters are tested.", {
  expect_equal(length(germplasm_pedigree(con, 1, rclass = "list")$result), 4)
  expect_equal(length(germplasm_pedigree(con, 5, rclass = "list")$result), 4)
  expect_equal(length(germplasm_pedigree(con, 5, notation = "purdue", rclass = "list")$result), 4)
  expect_equal(germplasm_pedigree(con, 5, rclass = "list")$result$pedigree, "landrace")
  expect_equal(germplasm_pedigree(con, 3, rclass = "list")$result$parent1Id, 1)
  expect_equal(germplasm_pedigree(con, 3, rclass = "list")$result$parent2Id, 2)
 })


test_that("Classes", {
  expect_equal("tbl_df" %in% class(germplasm_pedigree(con, 3, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(germplasm_pedigree(con, 3, rclass = "json")), TRUE)
  expect_equal("list" %in% class(germplasm_pedigree(con, 3, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(germplasm_pedigree(con, 3, rclass = "data.frame")), TRUE)
  expect_equal("brapi_germplasm_pedigree" %in% class(germplasm_pedigree(con, 3)), TRUE)
})


}
