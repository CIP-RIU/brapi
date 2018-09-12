context("ts observationvariables_details")

con <- ba_db()$testserver

test_that(" are present", {

  res <- ba_observationvariables_details(con = con, observationVariableDbId = "MO_123:100002")
  expect_that(nrow(res) == 1, is_true())

})

test_that(" required works", {
  expect_error(
    res <- ba_observationvariables_details(con = con)
  )
})

test_that(" out formats work", {

  res <- ba_observationvariables_details(con = con, observationVariableDbId = "MO_123:100002", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_observationvariables_details(con = con, observationVariableDbId = "MO_123:100002", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_observationvariables_details(con = con, observationVariableDbId = "MO_123:100002", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

