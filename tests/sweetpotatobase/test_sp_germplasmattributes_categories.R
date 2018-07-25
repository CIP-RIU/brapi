context("sp germplasmattributes_categories")

con <- ba_db()$sweetpotatobase

test_that(" are present", {

  res <- ba_germplasmattributes_categories(con = con)
  expect_that(nrow(res) >= 1, is_true())

})

