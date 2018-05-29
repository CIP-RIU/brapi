context("studies_studytypes")

con <- ba_db()$testserver

test_that("Studies_studytypes are present", {

  res <- ba_studies_studytypes(con = con)
  expect_that(nrow(res) == 3, is_true())

})


test_that("Output is transformed", {

  res <- ba_studies_studytypes(con = con, rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
