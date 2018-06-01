context("studies_search")

con <- ba_db()$testserver

test_that("Studies_search are present", {

  res <- ba_studies_search(con = con)
  expect_that(nrow(res) == 6, is_true())

})

test_that("Studies_search out formats work", {

  res <- ba_studies_search(con = con, rclass = "json")
  expect_that("json" %in% class(res) , is_true())
  res <- ba_studies_search(con = con, rclass = "list")
  expect_that("list" %in% class(res) , is_true())
  res <- ba_studies_search(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(res) , is_true())

})


con <- ba_db()$sweetpotatobase
test_that("POST works", {

  res <- ba_studies_search(con = con, verb = 'POST')
  expect_that(nrow(res) >= 340, is_true())

  res <- ba_studies_search(con = con, rclass = "json", verb = "POST")
  expect_that("json" %in% class(res) , is_true())

})
