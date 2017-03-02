# source("check_server_status.R")
#
# if (check_server_status == 200) {

context("Testing the helper function check_ba")
  #con <- ba_connect(secure = FALSE)

test_that("Check parameters work.", {

  expect_error(brapi:::check_ba(bms = "x"))

})


# }
