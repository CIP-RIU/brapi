source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'traits'")

test_that("Basics.", {
  expect_equal(length(brapi_traits(rclass = "list")), 2)
  expect_equal(nrow(brapi_traits(rclass = "data.frame")), 5)
})

test_that("Parameters", {
  expect_equal(nrow(brapi_traits(page = 0)), 5)
  expect_equal(nrow(brapi_traits(page = 1, pageSize = 3)), 2)
})


test_that("Classes", {
  expect_equal("json" %in% class(brapi_traits(rclass = "json")), TRUE)
  expect_equal("json" %in% class(brapi_traits(rclass = "something")), TRUE)
  expect_equal("list" %in% class(brapi_traits(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(brapi_traits(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(brapi_traits()), TRUE)
  expect_equal("brapi_traits" %in% class(brapi_traits()), TRUE)
})

}

