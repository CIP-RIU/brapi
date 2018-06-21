context("germplasmattributes")

con <- ba_db()$testserver

test_that(" are present", {

  res <- ba_germplasmattributes(con = con)
  expect_that(nrow(res) == 10, is_true())

})

