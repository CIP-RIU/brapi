source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'ontologies'")

  con <- connect(secure = FALSE)

test_that("brapi_variables_ontologies are listed.", {
  expect_equal(length(observationvariables_ontologies(con, rclass = "list")), 2)
})


test_that("Parameters", {
  expect_equal(nrow(observationvariables_ontologies(con, page = 0)), 2)
  expect_equal(nrow(observationvariables_ontologies(con, page = 1, pageSize = 1)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(observationvariables_ontologies(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(observationvariables_ontologies(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(observationvariables_ontologies(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(observationvariables_ontologies(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(observationvariables_ontologies(con )), TRUE)
  expect_equal("brapi_observationvariables_ontologies" %in% class(observationvariables_ontologies(con )), TRUE)
})


}
