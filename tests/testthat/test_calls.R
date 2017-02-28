source("check_server_status.R")

if (check_server_status == 200) {


context("Testing the path 'calls'")

  con <- ba_connect(secure = FALSE)

test_that("Calls are listed.", {
  expect_equal(length(ba_calls(con, rclass = "list")), 2)
  expect_equal(ncol(ba_calls(con)), 3)
})

test_that("Calls are listed.", {
  expect_equal(length(ba_calls(con, rclass = "list")), 2)
  expect_equal(ncol(ba_calls(con)), 3)
})

test_that("Paging works.", {
  expect_equal(nrow(ba_calls(con, pageSize = 3)), 3)
})

test_that("Calls parameters work.", {
  expect_equal(nrow(ba_calls(con, datatypes = "json")), 44)
  expect_equal(nrow(ba_calls(con, datatypes = "csv")), 3)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_calls(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(ba_calls(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(ba_calls(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_calls(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_calls(con )), TRUE)
  expect_equal("ba_calls" %in% class(ba_calls(con )), TRUE)
})


}
