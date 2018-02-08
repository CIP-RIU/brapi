context("Crops call")

con <- ba_db()$sweetpotatobase

test_that("Crops are present", {

  res <- ba_crops(con = con)
  expect_that(nrow(res) == 1, is_true())

})

test_that("Crops output formats work", {

  res <- ba_crops(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

})
