context("ts markerprofiles_allelematrices_search_post")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_markerprofiles_allelematrices_search_post(con = con, markerprofileDbId = "mr1")
  expect_that(nrow(res) >= 2, is_true())

})
