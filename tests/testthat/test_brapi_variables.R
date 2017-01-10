source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'variables'")

test_that("brapi_variables are listed.", {
  expect_equal(length(brapi_variables(rclass = "list")), 2)
})


test_that("Parameters", {
  expect_equal(nrow(brapi_variables(page = 0)), 4)
  expect_equal(nrow(brapi_variables(page = 1, pageSize = 1)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(brapi_variables(rclass = "json")), TRUE)
  expect_equal("json" %in% class(brapi_variables(rclass = "something")), TRUE)
  expect_equal("list" %in% class(brapi_variables(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(brapi_variables(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(brapi_variables()), TRUE)
  expect_equal("brapi_variables" %in% class(brapi_variables()), TRUE)
})


}
