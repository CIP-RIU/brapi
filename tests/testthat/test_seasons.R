source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'seasons'")


test_that("Seasons are listed.", {
  expect_equal(length(seasons()), 2)
})


}
