context("observationvariables_search")


con <- ba_db()$testserver

test_that("observationvariables_search results are present", {

  res <- ba_observationvariables_search(con = con, pageSize = 3)
  expect_that(nrow(res) == 3, is_true())
  expect_that(ncol(res) == 40, is_true())

})
