context("ts calls")
#testthat::skip_on_cran()

con <- ba_db()$testserver

test_that(" ts Calls are present", {

  res <- ba_calls(con = con, pageSize = 100)
  expect_true(nrow(res) >= 65)
  expect_true(length(attr(res, "metadata")) == 3)

})

test_that("Calls output formats work", {

  res <- ba_calls(con = con, datatype = "csv", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

