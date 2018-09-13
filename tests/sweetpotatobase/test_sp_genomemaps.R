context("sp genomemaps")

con <- ba_db()$sweetpotatobase

test_that("Genomemaps are present", {

  res <- ba_genomemaps(con = con)
  expect_that(nrow(res) == 1, is_true())

})


