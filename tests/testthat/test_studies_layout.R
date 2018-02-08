context("studies_layout")

con <- ba_db()$sweetpotatobase

test_that("Studies_layout are present", {

  res <- ba_studies_layout(con = con, studyDbId = "136")
  expect_that(nrow(res) == 10, is_true())

})


test_that("Output is transformed", {

  res <- ba_studies_layout(con = con, studyDbId = "140", rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
