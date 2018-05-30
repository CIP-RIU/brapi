context("markers_details")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_markers_details(con = con)
  expect_that(nrow(res) == 22, is_true())

})
