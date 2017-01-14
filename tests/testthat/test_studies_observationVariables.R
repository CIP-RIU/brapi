source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/observationVariables'")

  con <- connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(studies_observationvariables(con, rclass = "list")), 2)
  expect_equal(nrow(studies_observationvariables(con, rclass = "data.frame")), 2)
  expect_equal(ncol(studies_observationvariables(con, rclass = "data.frame")), 42)
})

test_that("Parameters", {
  expect_equal(nrow(studies_observationvariables(con, 1)), 2)
  expect_equal(nrow(studies_observationvariables(con, 2)), 3)
})


test_that("Classes", {
  expect_equal("json" %in% class(studies_observationvariables(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(studies_observationvariables(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(studies_observationvariables(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(studies_observationvariables(con )), TRUE)
  expect_equal("brapi_studies_observationvariables" %in% class(studies_observationvariables(con )), TRUE)
})

}
