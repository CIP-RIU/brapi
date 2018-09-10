context("ts traits_details")

con <- ba_db()$testserver

test_that("Traits_details are present", {

  res <- ba_traits_details(con = con, traitDbId = "1")
  expect_that(nrow(res) == 3, is_true())

})

test_that("Traits_details are present", {

  expect_error( ba_traits_details(con = con, traitDbId = "1",  rclass = "any"))

})

