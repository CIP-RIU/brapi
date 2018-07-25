context("sp calls")
#testthat::skip_on_cran()

con <- ba_db()$sweetpotatobase

test_that(" ts calls are present", {

  res <- ba_calls(con = con, pageSize = 100)
  expect_true(nrow(res) >= 48)
  expect_true(length(attr(res, "metadata")) == 3)

})

test_that("calls output formats work", {

  res <- ba_calls(con = con, datatype = "csv", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

