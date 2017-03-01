source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studyTypes'")

  con <- ba_connect(secure = FALSE)

test_that("studyTypes are listed.", {
  expect_equal(length(ba_studies_studytypes(con, rclass = "list")), 2)
  expect_equal(ncol(ba_studies_studytypes(con)), 2)
})

test_that("Calls parameters work.", {
  expect_equal(nrow(ba_studies_studytypes(con)), 3)
  expect_equal(nrow(ba_studies_studytypes(con, pageSize = 1)), 1)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_studies_studytypes(con, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_studies_studytypes(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_studies_studytypes(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_studies_studytypes(con, rclass = "data.frame")), TRUE)
  expect_equal("ba_studies_studytypes" %in% class(ba_studies_studytypes(con )), TRUE)
})


}
