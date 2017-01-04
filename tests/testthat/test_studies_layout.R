source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/layout'")

test_that("Basics.", {
  expect_equal(length(studies_layout(rclass = "list")), 2)
  expect_equal(nrow(studies_layout(rclass = "data.frame")), 6)
})

test_that("Classes", {
  expect_equal("json" %in% class(studies_layout(rclass = "json")), TRUE)
  expect_equal("list" %in% class(studies_layout(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(studies_layout(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(studies_layout()), TRUE)
  expect_equal("brapi_studies_layout" %in% class(studies_layout()), TRUE)
})

}

