context("traits")

con <- ba_db()$sweetpotatobase

test_that("Traits are present", {

  res <- ba_traits(con = con)
  expect_that(nrow(res) >= 222, is_true())

})


