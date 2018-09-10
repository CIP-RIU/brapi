context("ts traits")

con <- ba_db()$testserver

test_that("Traits are present", {

  res <- ba_traits(con = con)
  expect_that(nrow(res) >= 2, is_true())

})


