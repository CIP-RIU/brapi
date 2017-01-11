source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/germplasm'")

  con = connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(germplasm_details_study(con, rclass = "list")), 2)
  expect_equal(nrow(germplasm_details_study(con, rclass = "data.frame")), 3)
})


test_that("Paging", {
  expect_equal(nrow(germplasm_details_study(con, pageSize = 1)), 1)
  expect_equal(nrow(germplasm_details_study(con, pageSize = 1, page = 2)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(germplasm_details_study(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(germplasm_details_study(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(germplasm_details_study(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(germplasm_details_study(con )), TRUE)
  expect_equal("brapi_germplasm_details_study" %in% class(germplasm_details_study(con )), TRUE)
})

}

