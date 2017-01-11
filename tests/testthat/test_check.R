source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function check")
  con = connect(secure = FALSE)

test_that("Check parameters work.", {
  expect_message(check(con), regexp = "BrAPI connection ok.", all = FALSE)
  # expect_error(check(con, TRUE, "some"), regexp = "some not implemented by server:")
  # expect_error(check(con, TRUE, c("some", "thing")), regexp = "some, thing not implemented by server:")
})


}
