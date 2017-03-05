source("check_server_status.R")

if (check_server_status == 200) {

context("Testing 'can_internet'")

test_that("Can internet parameters work.", {

  expect_error(ba_can_internet(1))
  expect_error(ba_can_internet(TRUE))
})

}
