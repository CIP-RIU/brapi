context("sp markerprofiles_allelematrices_search")

con <- ba_db()$sweetpotatobase

test_that("Calls are present", {

  skip("Not implemented correctly on sweetpotatobase.")
  res <- ba_markerprofiles_allelematrices_search(con = con, pageSize = 10)
  expect_that(nrow(res) >= 2, is_true())

})
