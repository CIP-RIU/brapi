context("ts markerprofiles_allelematrices_search")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_markerprofiles_allelematrices_search(con = con)
  expect_that(nrow(res) >= 2, is_true())

})
