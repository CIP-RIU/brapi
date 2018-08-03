context("ts locations details")

con <- ba_db()$testserver

test_that("Location is present", {

  loc <- ba_locations_details(con = con, "1")
  expect_that(nrow(loc) == 1, is_true())
  expect_that(ncol(loc) == 19, is_true())

})

test_that("Locations output formats work", {

  loc <- ba_locations_details(con = con, "1", rclass = "json")
  expect_that("json" %in% class(loc), is_true())

  loc <- ba_locations_details(con = con, "1", rclass = "data.frame")
  expect_that("data.frame" %in% class(loc), is_true())

  loc <- ba_locations_details(con = con, "1", rclass = "list")
  expect_that("list" %in% class(loc), is_true())

})
