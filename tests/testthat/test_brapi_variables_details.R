source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'variables/{id}'")

test_that("brapi_variables_details are listed.", {
  expect_equal(length(brapi_variables_details(rclass = "list")), 2)
})



test_that("Classes", {
  expect_equal("json" %in% class(brapi_variables_details(rclass = "json")), TRUE)
  expect_equal("json" %in% class(brapi_variables_details(rclass = "something")), TRUE)
  expect_equal("list" %in% class(brapi_variables_details(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(brapi_variables_details(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(brapi_variables_details()), TRUE)
  expect_equal("brapi_variables_details" %in% class(brapi_variables_details()), TRUE)
})


}
