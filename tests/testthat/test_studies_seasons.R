source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'seasons'")

  con <- ba_connect(secure = FALSE)

test_that("Seasons are listed.", {
  expect_equal(length(ba_studies_seasons(con, rclass = "list")), 2)
  expect_equal(nrow(ba_studies_seasons(con, rclass = "data.frame")), 16)
  expect_equal(nrow(ba_studies_seasons(con, 2015)), 1)
  expect_equal(ba_studies_seasons(con, rclass = "list")$result$data[[10]]$year[1], 2008)
})


test_that("Parameters are tested.", {
  expect_equal(length(ba_studies_seasons(con, page = 0, pageSize = 1, rclass = "list")$result$data), 1)
  expect_equal(length(ba_studies_seasons(con, page = 0, pageSize = 2, rclass = "list")$result$data), 2)
  expect_equal(length(ba_studies_seasons(con, page = 1, pageSize = 1, rclass = "list")$result$data), 1)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_studies_seasons(con, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_studies_seasons(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_studies_seasons(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_studies_seasons(con, rclass = "data.frame")), TRUE)
  expect_equal("ba_studies_seasons" %in% class(ba_studies_seasons(con )), TRUE)
})


}
