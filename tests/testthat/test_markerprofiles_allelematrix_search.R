context("markerprofiles_allelematrix_search")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_markerprofiles_allelematrix_search(con = con)
  expect_that(nrow(res) == 22, is_true())

})
