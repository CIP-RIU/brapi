context("ba_check")

con <- ba_db()$testserver

test_that("Parameters work", {

  expect_error({
    ba_check(NULL)
  })

  expect_error({
    con$db = "128"
    ba_check(con)
  })


  expect_error({
    ba_check(con, verbose = TRUE)
  })

})

