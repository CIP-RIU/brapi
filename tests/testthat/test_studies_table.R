source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/table'")

  con <- ba_connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(ba_studies_table(con, studyDbId = "134", rclass = "list")), 2)
  expect_equal(nrow(ba_studies_table(con, studyDbId = "134", rclass = "data.frame")), 81)
  expect_equal(ncol(ba_studies_table(con, studyDbId = "134", rclass = "data.frame")), 39)
})

test_that("Parameters", {
  expect_equal(nrow(ba_studies_table(con, studyDbId = "134")), 81)
  #expect_equal(nrow(ba_studies_table(con, studyDbId = "134")), 61)
  expect_equal(nrow(ba_studies_table(con, studyDbId = "134", format = "tsv")), 81)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_studies_table(con, studyDbId = "134", rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_studies_table(con, studyDbId = "134", rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_studies_table(con, studyDbId = "134", rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_studies_table(con, studyDbId = "134" )), TRUE)
  expect_equal("ba_studies_table" %in% class(ba_studies_table(con,  studyDbId = "134" )), TRUE)
})

}
