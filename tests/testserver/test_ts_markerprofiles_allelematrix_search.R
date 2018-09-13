context("ts markerprofiles_allelematrix_search")

con <- ba_db()$testserver

test_that("Calls are present", {

  skip("Deprecated as of BrAPI version 1.2")

  res <- ba_markerprofiles_allelematrix_search(con = con)
  expect_that(nrow(res) >= 2, is_true())

})
