source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'variables'")

  con <- ba_connect(secure = FALSE)

test_that("brapi_variables are listed.", {
  expect_equal(length(ba_observationvariables(con, rclass = "list")), 2)
})


test_that("Parameters", {
  expect_equal(nrow(ba_observationvariables(con, page = 0)), 4)
  expect_equal(nrow(ba_observationvariables(con, page = 1, pageSize = 1)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_observationvariables(con, rclass = "json")), TRUE)

  expect_equal("list" %in% class(ba_observationvariables(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_observationvariables(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_observationvariables(con )), TRUE)
  expect_equal("ba_observationvariables" %in% class(ba_observationvariables(con )), TRUE)
})


}
