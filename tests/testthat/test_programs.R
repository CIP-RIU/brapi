source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'programs'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::programs()), 2)
  expect_equal(length(brapi::programs()$result$data), 2)
})

test_that("Parameters are tested.", {
  expect_equal(length(brapi::programs(page = 0, pageSize = 1)$result$data), 1)
  expect_equal(length(brapi::programs(page = 0, pageSize = 2)$result$data), 2)
  expect_equal(length(brapi::programs(page = 1, pageSize = 1)$result$data), 1)
})

}
