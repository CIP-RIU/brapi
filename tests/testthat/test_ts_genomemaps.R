context("genomemaps")

con <- ba_db()$testserver

test_that("Genomemaps are present", {

  res <- ba_genomemaps(con = con)
  expect_that(nrow(res) == 1, is_true())

})

test_that("Vector output is transformed", {

  res <- ba_genomemaps(con = con, rclass = "vector")
  expect_that("tbl_df" %in%  class(res), is_true())

})
