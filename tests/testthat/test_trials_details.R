context("trials_details")

con <- ba_db()$sweetpotatobase

test_that("Trials_details are present", {

  res <- ba_trials_details(con = con, trialDbId = "369")
  expect_that("2017" %in% res$trialName, is_true())

})

test_that("Output is transformed", {

  res <- ba_trials_details(con = con, trialDbId = "369", rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
