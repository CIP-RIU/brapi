context("ba_check")

con <- ba_db()$testserver

test_that("Parameters work", {

  expect_error({
    ba_check(NULL)
  })

  expect_message({
    con$db = "127"
    ba_check(con)
  })


  expect_message({
    ba_check(con, verbose = TRUE)
  })

})

