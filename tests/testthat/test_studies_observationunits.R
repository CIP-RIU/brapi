context("studies_observationunits")

con <- ba_db()$testserver

test_that("Studies_details are present", {

  res <- ba_studies_observationunits(con = con, studyDbId = "1001")
  expect_that(nrow(res) == 4, is_true())

})


test_that("Output is transformed", {

  res <- ba_studies_observationunits(con = con, studyDbId = "1001",
                                     rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
