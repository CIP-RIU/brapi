context("trials_details")

con <- ba_db()$testserver

test_that("Trials_details are present", {

  res <- ba_trials_details(con = con, trialDbId = "101")
  expect_that(nrow(res) > 0, is_true())

})

test_that("Output is transformed", {

  res <- ba_trials_details(con = con, trialDbId = "101", rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
