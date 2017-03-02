source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/table'")

  con <- ba_connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(ba_studies_table(con, rclass = "list")), 2)
  expect_equal(nrow(ba_studies_table(con, rclass = "data.frame")), 8)
  expect_equal(ncol(ba_studies_table(con, rclass = "data.frame")), 18)
})

test_that("Parameters", {
  expect_equal(nrow(ba_studies_table(con, studyDbId = "1")), 8)
  expect_equal(nrow(ba_studies_table(con, studyDbId = "2")), 6)
  expect_equal(nrow(ba_studies_table(con, studyDbId = "2", format = "tsv")), 6)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_studies_table(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_studies_table(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_studies_table(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_studies_table(con )), TRUE)
  expect_equal("ba_studies_table" %in% class(ba_studies_table(con )), TRUE)
})

}
