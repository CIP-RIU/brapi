

con <- ba_db()$sweetpotatobase

test_that("Locations are present", {

  loc <- ba_locations(con = con)
  expect_that(nrow(loc) == 10, is_true())

})

test_that("Locations output formats work", {

  loc <- ba_locations(con = con, rclass = "json")
  expect_that("json" %in% class(loc), is_true())

})
