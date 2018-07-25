context("ts observationvariables_datatypes")

con <- ba_db()$testserver

test_that("Studies_details are present", {

  res <- ba_observationvariables_datatypes(con = con)
  expect_that(nrow(res) >= 2, is_true())

})


