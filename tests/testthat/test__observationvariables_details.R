context("observationvariables_details")

con <- ba_db()$testserver

test_that(" are present", {

  res <- ba_observationvariables_details(con = con)
  expect_that(nrow(res) == 5, is_true())

})


