context("get_brapi")

con <- ba_db()$testserver

test_that("Parameters work", {
  expect_true(is.null(brapi:::get_brapi(NULL)))
})

test_that("Parameters work", {
  con$apipath = "test"
  res <- brapi:::get_brapi(con)
  expect_true( "https://test-server.brapi.org/test/brapi/v1/" == res)
})

test_that("Parameters work", {
  con$multicrop = TRUE
  res <- brapi:::get_brapi(con)
  expect_true( "https://test-server.brapi.org/crop1/brapi/v1/" == res)
})


test_that("Path versioning works", {
  con$version <- "v1.2"
  res <- brapi:::get_brapi(con)
  expect_true( "https://test-server.brapi.org/brapi/v1.2/" == res)

  con$version <- NULL
  res <- brapi:::get_brapi(con)
  expect_true( "https://test-server.brapi.org/brapi/v1/" == res)
})

