source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'attributes'")


test_that("Calls are listed.", {
  acall = brapi::attributes(rclass = "list")
  expect_equal(length(acall), 2)
  expect_equal(length(acall$result$data), 4)
})

test_that("Parameters are tested.", {
  acall = brapi::attributes(2)
  expect_equal(nrow(acall), 1)
  acall = brapi::attributes(1)
  expect_equal(nrow(acall), 2)
})

}
