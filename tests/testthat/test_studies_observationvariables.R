context("studies_observationvariables")

con <- ba_db()$sweetpotatobase

test_that("Studies_details are present", {

  res <- ba_studies_observationvariables(con = con, studyDbId = "148")
  expect_that(nrow(res) == 10, is_true())

})


test_that("Output is transformed", {

  res <- ba_studies_observationvariables(con = con, studyDbId = "148", rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
