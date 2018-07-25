context("studies_observationlevels")

con <- ba_db()$testserver

test_that("Studies_observationlevels are present", {

  res <- ba_studies_observationlevels(con = con)
  expect_that("plot" %in% res, is_true())

})


test_that("Output is transformed", {

  res <- ba_studies_observationlevels(con = con, rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
