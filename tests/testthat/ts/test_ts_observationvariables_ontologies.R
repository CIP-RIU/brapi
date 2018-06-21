context("observationvariables_ontologies")

con <- ba_db()$testserver

test_that("Studies_details are present", {

  res <- ba_observationvariables_ontologies(con = con)
  expect_that(nrow(res) == 1, is_true())

})

