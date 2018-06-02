context("connect")

#testthat::skip_on_cran()

con <- ba_db()$testserver

test_that(" are present", {

  res <- ba_connect(brapiDb = con)
  expect_that(length(res) == 15, is_true())

  res <- ba_connect(bms = TRUE)
  expect_true(res$multicrop)

})
