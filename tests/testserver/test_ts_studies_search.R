context("ts studies_search_get - Test-server does not work?")

con <- ba_db()$testserver



test_that("Studies_search are present", {
  res <- ba_studies_search(con = con, active = FALSE)
  expect_true(nrow(res) == 1)

})

test_that("Studies_search out formats work", {

  res <- ba_studies_search(con = con, active = FALSE, rclass = "json")
  expect_that("json" %in% class(res) , is_true())
  res <- ba_studies_search(con = con, active = FALSE, rclass = "list")
  expect_that("list" %in% class(res) , is_true())
  res <- ba_studies_search(con = con, active = FALSE, rclass = "data.frame")
  expect_that("data.frame" %in% class(res) , is_true())
})

