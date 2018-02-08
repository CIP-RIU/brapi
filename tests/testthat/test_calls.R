context("calls")

con <- ba_db()$sweetpotatobase

test_that("Calls are present", {

  res <- ba_calls(con = con, datatypes = "csv")
  expect_that(nrow(res) == 42, is_true())

})

test_that("Calls output formats work", {

  res <- ba_calls(con = con, datatypes = "csv", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

test_that("Calls page parameters work", {

  res <- ba_calls(con = con, datatypes = "csv", pageSize = 1000)
  expect_that(nrow(res) == 10, is_true())

})
