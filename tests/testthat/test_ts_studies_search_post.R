context("ts studies_search_post - Test-server does not work?")

con <- ba_db()$testserver



test_that("Studies_search are present", {
  # res <- ba_studies_search_post(con = con)
  # expect_that(nrow(res) >= 1, is_true())
  #expect_error({
    res <- ba_studies_search_post(con = con)
    expect_that(nrow(res) >= 1, is_true())
  #})

})

test_that("Studies_search out formats work", {

  #expect_error({
  res <- ba_studies_search_post(con = con, rclass = "json")
  expect_that("json" %in% class(res) , is_true())
  res <- ba_studies_search_post(con = con, rclass = "list")
  expect_that("list" %in% class(res) , is_true())
  res <- ba_studies_search_post(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(res) , is_true())
  #})
})

