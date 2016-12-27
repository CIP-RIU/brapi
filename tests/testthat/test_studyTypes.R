source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studyTypes'")

test_that("studyTypes are listed.", {
  expect_equal(length(calls(rclass = "list")), 2)
  expect_equal(ncol(studyTypes()), 2)
})

test_that("Calls parameters work.", {
  expect_equal(nrow(studyTypes()), 3)
  expect_equal(nrow(studyTypes(pageSize = 1)), 1)
})

}
