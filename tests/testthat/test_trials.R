source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'trials'")

test_that("Trials are listed.", {
  expect_equal(length(trials(rclass = "list")), 2)
  expect_equal(nrow(trials(rclass = "data.frame")), 11)
  expect_equal(nrow(trials(rclass = "tibble")), 11)
})


}

