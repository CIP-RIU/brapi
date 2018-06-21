context("sp trials")

con <- ba_db()$sweetpotatobase

test_that("Trials are present", {

  res <- ba_trials(con = con)
  expect_that(nrow(res) > 1, is_true())

})

test_that("Param checks work", {

  res <- ba_trials(con = con, programDbId = "135")
  expect_that(nrow(res) > 3, is_true())

})


test_that("Output is transformed", {

  res <- ba_trials(con = con, programDbId = "135", rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
