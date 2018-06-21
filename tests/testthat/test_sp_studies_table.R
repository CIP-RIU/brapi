context("sp studies_table")

# Brapi test server does not return correct header row, so using sweetpotatobase for the moment!
con <- ba_db()$sweetpotatobase

test_that("Studies_table are present", {

  res <- ba_studies_table(con = con, studyDbId = "148", format = 'csv')
  expect_that(nrow(res) >= 8, is_true())

})


test_that("Studies_table are presented as json", {

  res <- ba_studies_table(con = con, studyDbId = "148", format = 'csv', rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})

test_that("Studies_table are presented as data.frame", {

  res <- ba_studies_table(con = con, studyDbId = "148", format = 'csv', rclass = "data.frame")
  expect_that("data.frame" %in%  class(res), is_true())

})


test_that("Studies_table are requested as csv", {

  res <- ba_studies_table(con = con, studyDbId = "148", format = "csv")
  expect_that(nrow(res) >= 8, is_true())

})

test_that("Studies_table are requested as tsv", {

  res <- ba_studies_table(con = con, studyDbId = "148", format = "tsv")
  expect_that(nrow(res) >= 8, is_true())

})
