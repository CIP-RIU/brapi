context("programs_search")


con <- ba_db()$testserver

test_that("programs_search results are present", {

  #TODO find a server that implements it.
  # Neither testserver nor sweepotatobase do so.

  res <- ba_programs_search(con = con, pageSize = 3)
  expect_that(nrow(res) >= 1, is_true())

})
