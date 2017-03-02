source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'trials'")

  con <- ba_connect(secure = FALSE)

test_that("Trials are listed.", {
  expect_equal(length(ba_trials(con, rclass = "list")), 2)
  expect_equal(nrow(ba_trials(con, rclass = "data.frame")), 2)
  expect_equal(nrow(ba_trials(con, rclass = "tibble")), 2)
  expect_equal("ba_trials" %in% class(ba_trials(con )), TRUE)
})

test_that("parameters.", {
  expect_equal(nrow(ba_trials(con, programDbId = "any")), 2)
  expect_equal(nrow(ba_trials(con, active = FALSE)), 9)
})


}
