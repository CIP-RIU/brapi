source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'traits/id'")

test_that("Basics.", {
  expect_equal(length(brapi_traits_details(rclass = "list")), 2)
  expect_equal(nrow(brapi_traits_details(rclass = "data.frame")), 1)
})

test_that("Parameters", {
  expect_equal(nrow(brapi_traits_details()), 1)
  expect_equal(nrow(brapi_traits_details(5)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(brapi_traits_details(rclass = "json")), TRUE)
  expect_equal("json" %in% class(brapi_traits_details(rclass = "something")), TRUE)
  expect_equal("list" %in% class(brapi_traits_details(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(brapi_traits_details(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(brapi_traits_details()), TRUE)
  expect_equal("brapi_traits_details" %in% class(brapi_traits_details()), TRUE)
})

}

