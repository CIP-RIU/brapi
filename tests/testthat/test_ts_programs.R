context("programs")

con <- ba_db()$testserver

test_that("Programs are present", {

  res <- ba_programs(con = con)
  expect_true( nrow(res) >= 6 )

})

test_that("Programs output formats work", {

  res <- ba_programs(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

})
