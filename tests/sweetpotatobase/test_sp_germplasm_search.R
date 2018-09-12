context("sp germplasm_search")

con <- ba_db()$sweetpotatobase

test_that("Germplasm_search results are present", {

  res <- ba_germplasm_search(con = con, pageSize = 10)
  expect_that(nrow(res) > 9, is_true())

})

test_that("out formats work", {

  res <- ba_germplasm_search(con = con, rclass = "json", pageSize = 10)
  expect_that("json" %in% class(res), is_true())

  res <- ba_germplasm_search(con = con, rclass = "list", pageSize = 10)
  expect_that("list" %in% class(res), is_true())

  res <- ba_germplasm_search(con = con, rclass = "data.frame", pageSize = 10)
  expect_that("data.frame" %in% class(res), is_true())

})

# con <- ba_db()$sweetpotatobase
# test_that("Germplasm_search results are present using POST", {
#
#   res <- ba_germplasm_search(con = con, method = 'POST')
#   expect_that(nrow(res) > 9, is_true())
#
# })
