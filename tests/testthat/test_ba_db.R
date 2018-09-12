context("databases")

con <- ba_db()

test_that("DBs are present", {

  expect_that(length(con) == 18, is_true())

})

test_that("DBs contains at least one well-known", {

  expect_that("sweetpotatobase" %in% names(con), is_true())

})

