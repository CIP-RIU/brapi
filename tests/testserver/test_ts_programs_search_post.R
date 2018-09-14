context("ts programs_search_post")


con <- ba_db()$testserver

test_that("programs_search_post results are present", {

  res <- ba_programs_search_post(con = con, pageSize = 1)
  expect_that(nrow(res) == 1, is_true())

})
