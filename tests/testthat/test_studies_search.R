source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies-search'")

test_that("Studies are listed.", {
  expect_equal(length(studies_search(rclass = "list")), 2)
  expect_equal(nrow(studies_search(rclass = "data.frame")), 11)
  expect_equal(nrow(studies_search(rclass = "tibble")), 11)
})

test_that("Study type.", {
  expect_equal(nrow(studies_search("MET study")), 3)
})

test_that("POST.", {
  expect_equal(nrow(studies_search(germplasmDbIds = 1:1000)), 11)
})


test_that("Paging.", {
  expect_equal(nrow(studies_search(pageSize = 1)), 1)
  expect_equal(nrow(studies_search(pageSize = 3)), 3)
})



}

