source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'ontologies'")

test_that("brapi_variables_ontologies are listed.", {
  expect_equal(length(brapi_variables_ontologies(rclass = "list")), 2)
})


test_that("Parameters", {
  expect_equal(nrow(brapi_variables_ontologies(page = 0)), 2)
  expect_equal(nrow(brapi_variables_ontologies(page = 1, pageSize = 1)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(brapi_variables_ontologies(rclass = "json")), TRUE)
  expect_equal("json" %in% class(brapi_variables_ontologies(rclass = "something")), TRUE)
  expect_equal("list" %in% class(brapi_variables_ontologies(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(brapi_variables_ontologies(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(brapi_variables_ontologies()), TRUE)
  expect_equal("brapi_variables_ontologies" %in% class(brapi_variables_ontologies()), TRUE)
})


}
