source("check_server_status.R")

if (check_server_status == 200) {

context("Testing is.ba_status_ok")

test_that("printing messages", {
  resp <- list(status_code = 200)
  expect_equal(brapi:::is.ba_status_ok(resp), TRUE)

  resp <- list(status_code = 123)
  expect_equal(brapi:::is.ba_status_ok(resp), FALSE)

  resp <- list(status_code = 400)
  expect_error(brapi:::is.ba_status_ok(resp), regexp = "get result due to invalid request")

  resp <- list(status_code = 401)
  expect_error(brapi:::is.ba_status_ok(resp), regexp = "invalid/expired token")

  resp <- list(status_code = 403)
  expect_error(brapi:::is.ba_status_ok(resp), regexp = "not implemented")

  resp <- list(status_code = 404)
  expect_error(brapi:::is.ba_status_ok(resp), regexp = "not implemented")

  resp <- list(status_code = 500)
  expect_error(brapi:::is.ba_status_ok(resp), regexp = "internal server error")

  resp <- list(status_code = 501)
  expect_error(brapi:::is.ba_status_ok(resp), regexp = "internal server error")

}
)

}
