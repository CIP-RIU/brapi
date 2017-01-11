source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'variables/{id}'")

  con = connect(secure = FALSE)

test_that("observationvariables_details are listed.", {
  expect_equal(length(observationvariables_details(con, rclass = "list")), 2)
})



test_that("Classes", {
  expect_equal("json" %in% class(observationvariables_details(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(observationvariables_details(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(observationvariables_details(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(observationvariables_details(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(observationvariables_details(con)), TRUE)
  expect_equal("brapi_observationvariables_details" %in% class(observationvariables_details(con)), TRUE)
})


}
