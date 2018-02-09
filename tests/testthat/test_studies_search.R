context("studies_search")

con <- ba_db()$sweetpotatobase

test_that("Studies_search are present", {

  res <- ba_studies_search(con = con)
  expect_that("Ghana" %in% res$programName, is_true())

})

test_that("Output is transformed", {

  res <- ba_studies_search(con = con, rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})


test_that("Studies_search are present using POST", {

  res <- ba_studies_search(con = con, programDbId = "140", verb = 'POST')
  expect_that("Ghana" %in% res$programName, is_true())

})



test_that("Output is transformed", {

  res <- ba_studies_search(con = con, programDbId = "140", verb = 'POST', rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
