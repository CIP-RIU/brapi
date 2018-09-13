context("ts markers_details")

con <- ba_db()$testserver

test_that("Calls are present", {

  res <- ba_markers_details(con = con, markerDbId = "mr1")
  expect_that(nrow(res) == 2, is_true())

})
