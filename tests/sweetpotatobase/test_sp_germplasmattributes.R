context("sp germplasmattributes")

con <- ba_db()$sweetpotatobase

test_that("  are present", {

  skip("Implemented - but takes too long: more than 25sec!")
  res <- ba_germplasmattributes(con = con)
  expect_that(nrow(res) >= 10, is_true())

})

test_that("  out formats work", {

  skip("Implemented - but takes too long: more than 25sec!")

  res <- ba_germplasmattributes(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_germplasmattributes(con = con, rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_germplasmattributes(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})
