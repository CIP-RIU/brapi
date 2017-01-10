source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'variables/datatypes'")

test_that("brapi_variables_datatypes are listed.", {
  expect_equal(length(brapi_variables_datatypes(rclass = "list")), 2)
})


test_that("Classes", {
  expect_equal("json" %in% class(brapi_variables_datatypes(rclass = "json")), TRUE)
  expect_equal("json" %in% class(brapi_variables_datatypes(rclass = "something")), TRUE)
  expect_equal("list" %in% class(brapi_variables_datatypes(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(brapi_variables_datatypes(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(brapi_variables_datatypes()), TRUE)
  expect_equal("brapi_variables_datatypes" %in% class(brapi_variables_datatypes()), TRUE)
})


}
