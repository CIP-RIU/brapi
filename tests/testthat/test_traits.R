context("traits")

con <- ba_db()$sweetpotatobase

test_that("Traits are present", {

  res <- ba_traits(con = con)
  expect_that(nrow(res) == 212, is_true())

})


