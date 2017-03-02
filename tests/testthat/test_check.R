source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function check")
  con <- ba_connect(secure = FALSE)

test_that("Check parameters work.", {
  expect_message(ba_check(con), regexp = "BrAPI connection ok.", all = FALSE)

  spb <- brapi::ba_db()$sweetpotato
  expect_equal(ba_check(spb), TRUE)

  expect_error(ba_check("x"))
  expect_error(ba_check(spb, "x"))
  expect_error(ba_check(spb, 1))

  expect_error(ba_check(spb, TRUE, 1))
  expect_error(ba_check(spb, brapi_calls = FALSE))


})


}
