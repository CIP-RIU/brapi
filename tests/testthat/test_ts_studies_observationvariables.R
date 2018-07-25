context("ts studies_observationvariables")

con <- ba_db()$testserver

test_that("Studies_details are present", {

  res <- ba_studies_observationvariables(con = con, studyDbId = "1001")
  expect_that(nrow(res) >= 4, is_true())

})


test_that("Output is transformed", {

  res <- ba_studies_observationvariables(con = con, studyDbId = "1001", rclass = "json")
  expect_that("json" %in%  class(res), is_true())

  res <- ba_studies_observationvariables(con = con, studyDbId = "1001", rclass = "list")
  expect_that("list" %in%  class(res), is_true())

  res <- ba_studies_observationvariables(con = con, studyDbId = "1001", rclass = "data.frame")
  expect_that("data.frame" %in%  class(res), is_true())

})
