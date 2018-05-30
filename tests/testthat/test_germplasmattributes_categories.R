context("germplasmattributes_categories")

con <- ba_db()$testserver

test_that("Studies_details are present", {

  res <- ba_germplasmattributes_categories(con = con)
  expect_that(nrow(res) == 4, is_true())

})

