context("studies_layout")

con <- ba_db()$testserver

test_that("Studies_layout are present", {

  res <- ba_studies_layout(con = con, studyDbId = "1001")
  expect_that(nrow(res) >= 4, is_true())

})


test_that("Output is transformed", {

  res <- ba_studies_layout(con = con, studyDbId = "1001", rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
