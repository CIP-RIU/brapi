source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'traits/id'")

  con <- ba_connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(ba_traits_details(con, rclass = "list")), 2)
  expect_equal(nrow(ba_traits_details(con, rclass = "data.frame")), 1)
})

test_that("Parameters", {
  expect_equal(nrow(ba_traits_details(con, )), 1)
  expect_equal(nrow(ba_traits_details(con, 5)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_traits_details(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(ba_traits_details(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(ba_traits_details(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_traits_details(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_traits_details(con )), TRUE)
  expect_equal("ba_traits_details" %in% class(ba_traits_details(con)), TRUE)
})

}
