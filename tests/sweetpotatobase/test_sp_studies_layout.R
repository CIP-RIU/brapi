context("studies_layout")

con <- ba_db()$sweetpotatobase

test_that("Studies_layout are present", {
  #!! sweetpotatobase has default pageSize =10 !!
  res <- ba_studies_layout(con = con, studyDbId = "1292", pageSize = 28, page = 0)
  expect_that(nrow(res) >= 28, is_true())

})


test_that("Output is transformed", {

  res <- ba_studies_layout(con = con, studyDbId = "1292", rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
