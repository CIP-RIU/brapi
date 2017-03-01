source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'ontologies'")

  con <- ba_connect(secure = FALSE)

test_that("brapi_variables_ontologies are listed.", {
  expect_equal(length(ba_observationvariables_ontologies(con, rclass = "list")), 2)
})


test_that("Parameters", {
  expect_equal(nrow(ba_observationvariables_ontologies(con, page = 0)), 2)
  expect_equal(nrow(ba_observationvariables_ontologies(con, page = 1, pageSize = 1)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_observationvariables_ontologies(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(ba_observationvariables_ontologies(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(ba_observationvariables_ontologies(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_observationvariables_ontologies(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_observationvariables_ontologies(con )), TRUE)
  expect_equal("ba_observationvariables_ontologies" %in% class(ba_observationvariables_ontologies(con )), TRUE)
})


}
