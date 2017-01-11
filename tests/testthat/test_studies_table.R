source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/table'")

  con = connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(studies_table(con, rclass = "list")), 2)
  expect_equal(nrow(studies_table(con, rclass = "data.frame")), 8)
  expect_equal(ncol(studies_table(con, rclass = "data.frame")), 18)
})

test_that("Parameters", {
  expect_equal(nrow(studies_table(con, studyDbId = 1)), 8)
  expect_equal(nrow(studies_table(con, studyDbId = 2)), 6)
  expect_equal(nrow(studies_table(con, studyDbId = 2, format = "tsv")), 6)
})


test_that("Classes", {
  expect_equal("json" %in% class(studies_table(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(studies_table(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(studies_table(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(studies_table(con )), TRUE)
  expect_equal("brapi_studies_table" %in% class(studies_table(con )), TRUE)
})

}

