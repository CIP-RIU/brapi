source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'variables/{id}'")

  con <- ba_connect(secure = FALSE)

test_that("observationvariables_search are listed.", {
  expect_equal(length(ba_observationvariables_search(con, rclass = "list")), 2)
})


test_that("Classes", {
  ba_show_info(FALSE)
  expect_equal("json" %in% class(ba_observationvariables_search(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_observationvariables_search(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_observationvariables_search(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_observationvariables_search(con)), TRUE)
  expect_equal("ba_observationvariables_search" %in% class(ba_observationvariables_search(con)), TRUE)
})


}
