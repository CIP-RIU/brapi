context("germplasm_details_study")

con <- ba_db()$testserver

test_that("Germplasm_details study results are present", {

  res <- ba_germplasm_details_study(con = con, studyDbId = "1001")
  expect_that(nrow(res) == 4, is_true())

})
