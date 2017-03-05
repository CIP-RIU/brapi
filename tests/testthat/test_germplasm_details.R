source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}'")

  con <- ba_connect(secure = FALSE)

test_that("Calls are listed.", {
  expect_equal(length(ba_germplasm_details(con, rclass = "list")), 2)
})

test_that("Parameters are tested.", {
  expect_equal(nrow(ba_germplasm_details(con, )), 7)
  expect_equal(nrow(ba_germplasm_details(con, rclass = "data.frame")), 7)
  expect_equal(length(ba_germplasm_details(con, "1", rclass = "list")$result$data), 1)
  expect_equal(length(ba_germplasm_details(con, "5", rclass = "list")$result$data), 1)
 })


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_germplasm_details(con, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_germplasm_details(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_germplasm_details(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_germplasm_details(con, rclass = "data.frame")), TRUE)
  expect_equal("ba_germplasm_details" %in% class(ba_germplasm_details(con )), TRUE)
})


}
