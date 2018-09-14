context("ts trials")

con <- ba_db()$testserver

test_that("Trials are present", {

  res <- ba_trials(con = con, programDbId = "1", active = FALSE)
  expect_that(nrow(res) > 1, is_true())

})

test_that("Param checks work", {

  res <- ba_trials(con = con, programDbId = "1",  active = FALSE, pageSize = 1)
  expect_that(nrow(res) == 2, is_true())

})


test_that("Output is transformed", {

  res <- ba_trials(con = con, programDbId = "1", rclass = "json",  active = FALSE)
  expect_that("json" %in%  class(res), is_true())

})
