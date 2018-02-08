con <- ba_db()$sweetpotatobase

test_that("Studies_details are present", {

  res <- ba_studies_details(con = con, studyDbId = "136")
  expect_that(nrow(res) == 1, is_true())

})
