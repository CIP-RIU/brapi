context("sp markerprofiles_details")

con <- ba_db()$sweetpotatobase

test_that("  are present", {

  skip("No data on sweetpotatobase yet.")

  res <- ba_markerprofiles_details(con = con, markerprofilesDbId = "mp1" )
  expect_that(nrow(res) == 22, is_true())

})

test_that("  out formats work", {

  skip("No data on sweetpotatobase yet.")

  res <- ba_markerprofiles_details(con = con, markerprofilesDbId = "mp1", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_markerprofiles_details(con = con, markerprofilesDbId = "mp1", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_markerprofiles_details(con = con, markerprofilesDbId = "mp1", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})
