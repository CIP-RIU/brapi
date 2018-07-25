context("sp observationvariables_ontologies")

con <- ba_db()$sweetpotatobase

test_that("Studies_details are present", {

  res <- ba_observationvariables_ontologies(con = con)
  expect_that(nrow(res) >= 12, is_true())

})

