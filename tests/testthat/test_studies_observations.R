context("studies_observations")

con <- ba_db()$sweetpotatobase

test_that("Studies_observations are present", {

  res <- ba_studies_observations(con = con, studyDbId = "148", pageSize = 10)
  expect_true(nrow(res) == 10)

})


