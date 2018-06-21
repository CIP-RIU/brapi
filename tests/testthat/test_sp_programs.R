context("sp programs")

con <- ba_db()$sweetpotatobase

test_that("Programs are present", {

  res <- ba_programs(con = con)
  expect_that("Ghana" %in% res$name, is_true())

})

test_that("Programs output formats work", {

  res <- ba_programs(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

})
