context("show_expiration")

test_that("Calls are present", {

  expect_message({
    con <- list()
    con$expires_in = 3600
    ba_show_info(TRUE)
    ba_show_expiration(con = con)
  })

})
