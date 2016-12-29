source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'trials/id'")

test_that("Trials are listed.", {
  expect_equal(length(trial_by_id(1, rclass = "list")), 2)
  expect_equal(nrow(trial_by_id(1, rclass = "data.frame")), 1)
  expect_equal(nrow(trial_by_id(3, rclass = "tibble")), 3)
})


}

