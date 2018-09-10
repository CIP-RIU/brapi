context("ba_check")

testthat::skip_on_cran()


con <- ba_db()$testserver

test_that("Parameters work", {

  expect_error({
    ba_check(NULL)
  })


  expect_message({
    ba_show_info(TRUE)
    res <- ba_check(con, verbose = TRUE)
  })

})

