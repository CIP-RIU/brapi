source("check_server_status.R")

if (check_server_status == 200) {


context("Testing the path 'calls'")

  con = connect(secure = FALSE)

test_that("Calls are listed.", {
  expect_equal(length(calls(con, rclass = "list")), 2)
  expect_equal(ncol(calls(con)), 3)
})

test_that("Calls are listed.", {
  expect_equal(length(calls(con, rclass = "list")), 2)
  expect_equal(ncol(calls(con)), 3)
})

test_that("Paging works.", {
  expect_equal(nrow(calls(con, pageSize = 3)), 3)
})

test_that("Calls parameters work.", {
  expect_equal(nrow(calls(con, datatypes = "json")), 43)
  expect_equal(nrow(calls(con, datatypes = "csv")), 3)
})


test_that("Classes", {
  expect_equal("json" %in% class(calls(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(calls(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(calls(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(calls(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(calls(con )), TRUE)
  expect_equal("brapi_calls" %in% class(calls(con )), TRUE)
})


}
