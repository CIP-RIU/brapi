context("sp germplasm_search")

con <- ba_db()$sweetpotatobase

test_that("Germplasm_search results are present", {

  res <- ba_germplasm_search(con = con)
  expect_that(nrow(res) > 9, is_true())

})

test_that("out formats work", {

  res <- ba_germplasm_search(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_germplasm_search(con = con, rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_germplasm_search(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

con <- ba_db()$sweetpotatobase
test_that("Germplasm_search results are present using POST", {

  res <- ba_germplasm_search(con = con, method = 'POST')
  expect_that(nrow(res) > 9, is_true())

})
