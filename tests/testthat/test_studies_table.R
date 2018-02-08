context("studies_table")

con <- ba_db()$sweetpotatobase

test_that("Studies_table are present", {

  res <- ba_studies_table(con = con, studyDbId = "148")
  expect_that(nrow(res) == 21, is_true())

})


