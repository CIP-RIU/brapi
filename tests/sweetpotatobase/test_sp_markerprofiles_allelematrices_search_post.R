context("sp markerprofiles_allelematrices_search_post")

con <- ba_db()$sweetpotatobase

test_that("Calls are present", {

  skip("Not implemented correctly on sweetpotatobase.")
  res <- ba_markerprofiles_allelematrices_search_post(con = con, pageSize = 10)
  expect_that(nrow(res) >= 2, is_true())

})
