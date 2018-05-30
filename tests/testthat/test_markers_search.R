context("markers_search")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_markers_search(con = con)
  expect_that(nrow(res) == 22, is_true())

})
