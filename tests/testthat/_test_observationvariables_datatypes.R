source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'variables/datatypes'")

  con <- ba_connect(secure = FALSE)

test_that("observationvariables_datatypes are listed.", {
  expect_equal(length(ba_observationvariables_datatypes(con, rclass = "list")), 2)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_observationvariables_datatypes(con, rclass = "json")), TRUE)

  expect_equal("list" %in% class(ba_observationvariables_datatypes(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_observationvariables_datatypes(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_observationvariables_datatypes(con)), TRUE)
  expect_equal("ba_observationvariables_datatypes" %in% class(ba_observationvariables_datatypes(con)), TRUE)
})


}
