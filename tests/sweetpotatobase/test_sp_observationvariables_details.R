context("sp observationvariables_details")

con <- ba_db()$sweetpotatobase

test_that(" are present", {

  expect_error(
    res <- ba_observationvariables_details(con = con)
  )

  res <- ba_observationvariables_details(con = con, observationVariableDbId = "76716")
  expect_that(nrow(res) == 1, is_true())

})

test_that(" out formats work", {

  res <- ba_observationvariables_details(con = con, observationVariableDbId = "76716", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_observationvariables_details(con = con, observationVariableDbId = "76716", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_observationvariables_details(con = con, observationVariableDbId = "76716", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

