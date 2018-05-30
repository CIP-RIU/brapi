context("markerprofiles_details")

con <- ba_db()$testserver

test_that("  are present", {

  res <- ba_markerprofiles_details(con = con, markerprofilesDbId = "mp1" )
  expect_that(nrow(res) == 22, is_true())

})
