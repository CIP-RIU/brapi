context("ts markers_search_post")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_markers_search_post(con = con)
  expect_that(nrow(res) == 22, is_true())

})

test_that("Out formats work", {

  res <- ba_markers_search_post(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_markers_search_post(con = con, rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_markers_search_post(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})
