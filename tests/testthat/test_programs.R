source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'programs'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::programs()), 2)
  expect_equal(length(brapi::programs()$result$data), 2)
})

test_that("Parameters are tested.", {
  expect_equal(length(brapi::programs(page = 1, pageSize = 1)$result$data), 2)
  expect_equal(brapi::programs(page = 1, pageSize = 1)$metadata$status[[1]]$code, 200)
  expect_equal(brapi::programs(page = 1, pageSize = 1)$metadata$status[[1]]$message,
               "Parameters 'page' and 'pageSize' are not implemented.")
})

}
