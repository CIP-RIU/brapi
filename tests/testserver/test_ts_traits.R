context("ts traits")

con <- ba_db()$testserver

test_that("Traits are present", {

  res <- ba_traits(con = con)
  expect_that(nrow(res) >= 2, is_true())

})

test_that("paging works", {

  res <- ba_traits(con = con, pageSize = 1)
  expect_that(nrow(res) == 1, is_true())

  res <- ba_traits(con = con, pageSize = 1, page = 1)
  expect_that(nrow(res) == 1, is_true())

})

