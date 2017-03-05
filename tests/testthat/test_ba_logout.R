source("check_server_status.R")

if (check_server_status == 200) {


context("Testing the path 'token' for logout")

  con <- ba_connect(secure = FALSE)

test_that("Parameters work", {

  out <- ba_login(con)
  expect_message(ba_logout(out), "Successfully logged out!")

  out$token <- NULL
  expect_error(ba_logout(out))

})


}
