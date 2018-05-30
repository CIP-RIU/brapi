context("phenotypes_search")

con <- ba_db()$sweetpotatobase

test_that(" are present", {

  res <- ba_phenotypes_search(con = con)
  expect_that(nrow(res) >= 2, is_true())

})


