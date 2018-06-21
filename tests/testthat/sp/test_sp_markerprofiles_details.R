context("sp markerprofiles_details")

con <- ba_db()$sweetpotatobase

test_that("  are present", {


  res <- ba_markerprofiles_details(con = con, markerprofilesDbId = "1" )
  expect_that(nrow(res) == 0, is_true())

})

