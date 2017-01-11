source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/layout'")

  con = connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(studies_layout(con, rclass = "list")), 2)
  expect_equal(nrow(studies_layout(con, rclass = "data.frame")), 6)
})

test_that("Classes", {
  expect_equal("json" %in% class(studies_layout(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(studies_layout(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(studies_layout(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(studies_layout(con )), TRUE)
  expect_equal("brapi_studies_layout" %in% class(studies_layout(con)), TRUE)
})

}

