context("sp locations")

con <- ba_db()$sweetpotatobase

test_that("Locations are present", {

  loc <- ba_locations(con = con, pageSize = 10)
  expect_that(nrow(loc) >= 9, is_true())

})

test_that("Locations output formats work", {

  loc <- ba_locations(con = con, rclass = "json", pageSize = 10)
  expect_that("json" %in% class(loc), is_true())

})
