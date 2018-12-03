context("sp studies_observationunits")

con <- ba_db()$sweetpotatobase

test_that("Studies_details are present", {

  skip("Under revision")

  res <- ba_studies_observationunits(con = con, studyDbId = "1180")
  expect_that(nrow(res) == 4, is_true())

})


test_that("Output is transformed", {

  skip("Under revision")

  res <- ba_studies_observationunits(con = con, studyDbId = "1180",
                                     rclass = "json")
  expect_that("json" %in%  class(res), is_true())


  res <- ba_studies_observationunits(con = con, studyDbId = "1180",
                                     rclass = "list")
  expect_that("list" %in%  class(res), is_true())


  res <- ba_studies_observationunits(con = con, studyDbId = "1180",
                                     rclass = "data.frame")
  expect_that("data.frame" %in%  class(res), is_true())

})
