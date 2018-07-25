context("ts germplasm_details_study")

con <- ba_db()$testserver

test_that("Germplasm_details study results are present", {

  res <- ba_germplasm_details_study(con = con, studyDbId = "1001")
  expect_that(nrow(res) == 4, is_true())

})

test_that("Germplasm_details out formats work", {

  res <- ba_germplasm_details_study(con = con, studyDbId = "1001", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_germplasm_details_study(con = con, studyDbId = "1001", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_germplasm_details_study(con = con, studyDbId = "1001", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

