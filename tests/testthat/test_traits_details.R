context("traits_details")

con <- ba_db()$sweetpotatobase

test_that("Traits_details are present", {

  res <- ba_traits_details(con = con)
  expect_that(nrow(res) == 10, is_true())

})

test_that("Traits_details are present", {

  expect_error( ba_traits_details(con = con, rclass = "any"))

})

