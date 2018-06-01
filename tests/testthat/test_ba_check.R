context("ba_check")

testthat::skip_on_cran()


con <- ba_db()$testserver

test_that("Parameters work", {

  # expect_error({
  #   ba_check(NULL)
  # })

  # TODO: revise the following: does not raise a message or error on Travis

  # expect_message({
  #   con$db = "127"
  #   ba_check(con)
  # })
  #
  #
  # expect_message({
  #   ba_check(con, verbose = TRUE)
  # })

})

