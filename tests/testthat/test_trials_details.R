source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'trials/id'")

  con <- connect(secure = FALSE)

test_that("Trials are listed.", {
  expect_equal(length(trials_details(con, 1, rclass = "list")), 2)
  expect_equal(nrow(trials_details(con, 1, rclass = "data.frame")), 1)
  expect_equal(nrow(trials_details(con, 3, rclass = "tibble")), 3)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(trials_details(con, 1, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(trials_details(con, 1, rclass = "json")), TRUE)
  expect_equal("list" %in% class(trials_details(con, 1, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(trials_details(con, 1, rclass = "data.frame")), TRUE)
  expect_equal("brapi_trials_details" %in% class(trials_details(con, 1  )), TRUE)
})


}
