source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/table'")

test_that("Basics.", {
  expect_equal(length(brapi_studies_table(rclass = "list")), 2)
  expect_equal(nrow(brapi_studies_table(rclass = "data.frame")), 8)
  expect_equal(ncol(brapi_studies_table(rclass = "data.frame")), 18)
})

test_that("Parameters", {
  expect_equal(nrow(brapi_studies_table(studyDbId = 1)), 8)
  expect_equal(nrow(brapi_studies_table(studyDbId = 2)), 6)
  expect_equal(nrow(brapi_studies_table(studyDbId = 2, format = "tsv")), 6)
})


test_that("Classes", {
  expect_equal("json" %in% class(brapi_studies_table(rclass = "json")), TRUE)
  expect_equal("list" %in% class(brapi_studies_table(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(brapi_studies_table(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(brapi_studies_table()), TRUE)
  expect_equal("brapi_studies_table" %in% class(brapi_studies_table()), TRUE)
})

}

