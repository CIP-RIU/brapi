source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'seasons'")

test_that("Seasons are listed.", {
  expect_equal(length(seasons()), 2)
  expect_equal(length(seasons(rclass = "list")), 2)
  expect_equal(nrow(seasons(rclass = "data.frame")), 10)
  expect_equal(seasons()$result$data[[10]]$year[1], 2008)
})


}
