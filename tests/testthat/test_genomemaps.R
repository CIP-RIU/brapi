
con <- ba_db()$germinate_test

test_that("Genomemaps are present", {

  res <- ba_genomemaps(con = con)
  expect_that(nrow(res) == 1, is_true())

})

test_that("Vector output is transformed", {

  res <- ba_genomemaps(con = con, rclass = "vector")
  expect_that("tbl_df" %in%  class(res), is_true())

})
