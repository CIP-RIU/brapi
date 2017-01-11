source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'trials'")

  con = connect(secure = FALSE)

test_that("Trials are listed.", {
  expect_equal(length(trials(con, rclass = "list")), 2)
  expect_equal(nrow(trials(con, rclass = "data.frame")), 11)
  expect_equal(nrow(trials(con, rclass = "tibble")), 11)
  expect_equal("brapi_trials" %in% class(trials(con )), TRUE)
})

test_that("parameters.", {
  expect_equal(nrow(trials(con, programDbId = 1)), 2)
  expect_equal(nrow(trials(con, active = FALSE)), 9)

})


}

