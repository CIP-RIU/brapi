source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function check")
  con <- connect(secure = FALSE)

test_that("Check parameters work.", {
  expect_message(check(con), regexp = "BrAPI connection ok.", all = FALSE)
})


}
