source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'traits'")

  con <- connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(traits(con, rclass = "list")), 2)
  expect_equal(nrow(traits(con, rclass = "data.frame")), 5)
})

test_that("Parameters", {
  expect_equal(nrow(traits(con, page = 0)), 5)
  expect_equal(nrow(traits(con, page = 1, pageSize = 3)), 2)
})


test_that("Classes", {
  expect_equal("json" %in% class(traits(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(traits(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(traits(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(traits(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(traits(con)), TRUE)
  expect_equal("brapi_traits" %in% class(traits(con )), TRUE)
})

}
