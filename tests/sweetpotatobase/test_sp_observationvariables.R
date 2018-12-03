context("sp observationvariables")

con <- ba_db()$sweetpotatobase

test_that(" are present", {

  res <- ba_observationvariables(con = con)
  expect_that(nrow(res) >= 10, is_true())

})


test_that(" out formats work", {

  res <- ba_observationvariables(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_observationvariables(con = con, rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_observationvariables(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})
