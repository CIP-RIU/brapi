context("sp programs_search_post")


con <- ba_db()$sweetpotatobase

test_that("programs_search_post results are present", {

  #TODO find a server that implements it.
  # Neither testserver nor sweepotatobase do so.

  skip("Not implemented.")

  res <- ba_programs_search_post(con = con, pageSize = 3)
  expect_that(nrow(res) >= 1, is_true())

})
