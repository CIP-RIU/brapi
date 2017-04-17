source("check_server_status.R")

if (check_server_status == 200) {


context("Testing the path 'calls'")

  con <- ba_connect(secure = FALSE)
  imp <- 52

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
  expect_equal(nrow(ba_calls(con, pageSize = 1000)), imp)
  expect_error(ba_calls(con, pageSize = 0))
  expect_error(ba_calls(con, page = -1))
  expect_error(ba_calls(con, pageSize = "x"))
})

test_that("Calls parameters work.", {
  expect_equal(nrow(ba_calls(con, datatypes = "json")), imp - 2)
  expect_equal(nrow(ba_calls(con, datatypes = "csv")), 3)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_calls(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_calls(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_calls(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_calls(con )), TRUE)
  expect_equal("ba_calls" %in% class(ba_calls(con )), TRUE)
})

test_that("Parameters", {
  expect_error(ba_calls(con, datatypes = "x"))
  expect_error(ba_calls(con, datatypes = 1))
  expect_silent(ba_calls(con, datatypes = "json"))
  expect_silent(ba_calls(con, datatypes = "csv"))
  expect_silent(ba_calls(con, datatypes = "tsv"))
  expect_silent(ba_calls(con, datatypes = "all"))
})


}
