context("sp markerprofiles_allelematrix_search")

con <- ba_db()$sweetpotatobase

test_that("Calls are present", {

  skip("Deprecated.")

  res <- ba_markerprofiles_allelematrix_search(con = con)
  expect_that(nrow(res) >= 2, is_true())

})
