source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'maps'")

  con = connect(secure = FALSE)

test_that("maps are listed.", {
  expect_equal(length(genomemaps(con, rclass = "list")), 2)
  expect_equal(ncol(genomemaps(con)), 9)
  expect_equal(nrow(genomemaps(con)), 3)
})

test_that("map parameters work.", {
  expect_equal(nrow(genomemaps(con, species = "batatas")), 2)
  expect_equal(nrow(genomemaps(con, type = "Physical")), 1)
})

test_that("map paging work.", {
  expect_equal(nrow(genomemaps(con, pageSize = 1)), 1)
  expect_equal(nrow(genomemaps(con, pageSize = 1, page = 2)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(genomemaps(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(genomemaps(con, rclass = "something")), TRUE)
  expect_equal("list" %in% class(genomemaps(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(genomemaps(con, rclass = "data.frame")), TRUE)
  expect_equal("brapi_genomemaps" %in% class(genomemaps(con )), TRUE)
})


}
