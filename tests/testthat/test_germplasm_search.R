context("germplasm_search")

con <- ba_db()$testserver

test_that("Germplasm_search results are present", {

  res <- ba_germplasm_search(con = con)
  expect_that(nrow(res) == 9, is_true())

})

con <- ba_db()$sweetpotatobase
test_that("Germplasm_search results are present using POST", {

  res <- ba_germplasm_search(con = con, method = 'POST')
  expect_that(nrow(res) == 10, is_true())

})
