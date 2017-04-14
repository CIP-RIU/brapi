source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'trials/id'")

  con <- ba_connect(secure = FALSE)

test_that("Trials are listed.", {
  expect_equal(length(ba_trials_details(con, "101", rclass = "list")), 2)
  expect_equal(nrow(ba_trials_details(con, "101", rclass = "data.frame")), 1)
  expect_equal(nrow(ba_trials_details(con, "103", rclass = "tibble")), 3)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_trials_details(con, "101", rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_trials_details(con, "101", rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_trials_details(con, "101", rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_trials_details(con, "101", rclass = "data.frame")), TRUE)
  expect_equal("ba_trials_details" %in% class(ba_trials_details(con, "101"  )), TRUE)
})


}
