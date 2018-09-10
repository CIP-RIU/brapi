context("ts studies_search_get - Test-server does not work?")

con <- ba_db()$testserver



test_that("Studies_search are present", {
  res <- ba_studies_search_get(con = con)
  expect_true(nrow(res) == 3)

})

test_that("Studies_search out formats work", {

  res <- ba_studies_search_get(con = con, rclass = "json")
  expect_that("json" %in% class(res) , is_true())
  res <- ba_studies_search_get(con = con, rclass = "list")
  expect_that("list" %in% class(res) , is_true())
  res <- ba_studies_search_get(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(res) , is_true())
})

