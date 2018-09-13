context("ts markerprofiles_allelematrices_details")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_markerprofiles_allelematrices_details(con = con, studyDbId = "1001" )
  expect_that(nrow(res) >= 1, is_true())

})
