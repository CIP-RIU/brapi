con <- ba_db()$sweetpotatobase

test_that("Trials are present", {

  res <- ba_trials(con = con)
  expect_that("2015" %in% res$trialName, is_true())

})

test_that("Output is transformed", {

  res <- ba_trials(con = con, rclass = "json")
  expect_that("json" %in%  class(res), is_true())

})
