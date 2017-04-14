source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/layout'")

  con <- ba_connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(ba_studies_layout(con, studyDbId = "1001", rclass = "list")), 2)
  expect_equal(nrow(ba_studies_layout(con, studyDbId = "1001", rclass = "data.frame")), 6)
})

test_that("Classes", {
  expect_equal("json" %in% class(ba_studies_layout(con, studyDbId = "1001", rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_studies_layout(con, studyDbId = "1001", rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_studies_layout(con, studyDbId = "1001", rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_studies_layout(con, studyDbId = "1001" )), TRUE)
  expect_equal("ba_studies_layout" %in% class(ba_studies_layout(con, studyDbId = "1001")), TRUE)
})

}
