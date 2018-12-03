context("ts genomemaps")

con <- ba_db()$testserver

test_that("Genomemaps are present", {

  res <- ba_genomemaps(con = con)
  expect_that(nrow(res) == 2, is_true())

})

test_that("Vector output is transformed", {

  res <- ba_genomemaps(con = con, rclass = "data.frame")
  expect_that("data.frame" %in%  class(res), is_true())

})
