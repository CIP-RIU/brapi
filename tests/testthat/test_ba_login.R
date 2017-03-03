source("check_server_status.R")

if (check_server_status == 200) {


context("Testing the path 'token'")

  con <- ba_connect(secure = FALSE)

test_that("Parameters work", {
  aut <- ba_login(con)
  expect_equal(aut$token, "R6gKDBRxM4HLj6eGi4u5HkQjYoIBTPfvtZzUD8TUzg4")

  expect_error(ba_login(NULL))

  con$password <- ""
  expect_error(ba_login(con))

  con <- ba_connect(secure = FALSE)
  con$user <- ""
  con$bms <- TRUE
  expect_error(ba_login(con))

})


}
