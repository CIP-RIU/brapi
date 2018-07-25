context("sp observationvariables_datatypes")

con <- ba_db()$sweetpotatobase

test_that("Studies_details are present", {

  skip("Not data implemented.")

  res <- ba_observationvariables_datatypes(con = con)
  expect_that(nrow(res) >= 2, is_true())

})


