source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'traits'")

  con <- ba_connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(ba_traits(con, rclass = "list")), 2)
  expect_equal(nrow(ba_traits(con, rclass = "data.frame")), 5)
})

test_that("Parameters", {
  expect_equal(nrow(ba_traits(con, page = 0)), 5)
  expect_equal(nrow(ba_traits(con, page = 1, pageSize = 3)), 2)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_traits(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(ba_traits(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(ba_traits(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_traits(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_traits(con)), TRUE)
  expect_equal("ba_traits" %in% class(ba_traits(con )), TRUE)
})

}
