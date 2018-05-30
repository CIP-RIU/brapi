context("studies_search")

con <- ba_db()$testserver

test_that("Studies_search are present", {

  res <- ba_studies_search(con = con)
  expect_that(nrow(res) == 6, is_true())

})


con <- ba_db()$sweetpotatobase
test_that("POST works", {

  res <- ba_studies_search(con = con, verb = 'POST')
  expect_that(nrow(res) >= 340, is_true())

})
