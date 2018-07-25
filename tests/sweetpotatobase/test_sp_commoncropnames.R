context("sp commoncropnames")

con <- ba_db()$sweetpotatobase

test_that("common crop names", {

  skip("Not yet implemented by sweetpotatobase")
  ccn <- ba_commoncropnames(con = con)
  expect_that(nrow(ccn) >= 2, is_true())

})

test_that("... output formats work", {

  skip("Not yet implemented by sweetpotatobase")
  ccn <- ba_commoncropnames(con = con, rclass = "json")
  expect_that("json" %in% class(ccn), is_true())

  skip("Not yet implemented by sweetpotatobase")
  ccn <- ba_commoncropnames(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(ccn), is_true())

})
