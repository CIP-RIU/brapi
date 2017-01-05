source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/observationVariables'")

test_that("Basics.", {
  expect_equal(length(studies_observationVariables(rclass = "list")), 2)
  expect_equal(nrow(studies_observationVariables(rclass = "data.frame")), 2)
  expect_equal(ncol(studies_observationVariables(rclass = "data.frame")), 42)
})

test_that("Parameters", {
  expect_equal(nrow(studies_observationVariables(1)), 2)
  expect_equal(nrow(studies_observationVariables(2)), 3)
})


test_that("Classes", {
  expect_equal("json" %in% class(studies_observationVariables(rclass = "json")), TRUE)
  expect_equal("list" %in% class(studies_observationVariables(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(studies_observationVariables(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(studies_observationVariables()), TRUE)
  expect_equal("brapi_studies_observationVariables" %in% class(studies_observationVariables()), TRUE)
})

}

