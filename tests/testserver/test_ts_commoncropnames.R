context("ts commoncropnames")

con <- ba_db()$testserver

test_that("common crop names", {

  ccn <- ba_commoncropnames(con = con)
  expect_that(nrow(ccn) >= 2, is_true())

})

test_that("... output formats work", {

  ccn <- ba_commoncropnames(con = con, rclass = "json")
  expect_that("json" %in% class(ccn), is_true())

  ccn <- ba_commoncropnames(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(ccn), is_true())

})
