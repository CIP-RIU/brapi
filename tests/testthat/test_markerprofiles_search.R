context("markerprofiles_search")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_markerprofiles_search(con = con)
  expect_that(nrow(res) == 3, is_true())

})

