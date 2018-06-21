context("ts markerprofiles_search")

con <- ba_db()$sweetpotatobase

test_that("Calls are present", {

  res <- ba_markerprofiles_search(con = con)
  expect_that(nrow(res) >= 0, is_true())

})

