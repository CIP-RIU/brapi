context("show_expiration")

con <- ba_db()$testserver
ba_show_info(TRUE)

test_that("Calls are present", {


  expect_message({
    ba_show_expiration(con = con)
  })

})
