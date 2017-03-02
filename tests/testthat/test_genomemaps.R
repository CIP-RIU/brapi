source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'maps'")

  con <- ba_connect(secure = FALSE)

test_that("maps are listed.", {
  expect_equal(length(ba_genomemaps(con, rclass = "list")), 2)
  expect_equal(ncol(ba_genomemaps(con)), 9)
  expect_equal(nrow(ba_genomemaps(con)), 3)
})

test_that("map parameters work.", {
  expect_equal(nrow(ba_genomemaps(con, species = "Fructus")), 3)
  expect_equal(nrow(ba_genomemaps(con, species = "novus")), 3)
  expect_equal(nrow(ba_genomemaps(con, type = "Physical")), 1)
})

test_that("map paging work.", {
  expect_equal(nrow(ba_genomemaps(con, pageSize = 1)), 1)
  expect_equal(nrow(ba_genomemaps(con, pageSize = 1, page = 2)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_genomemaps(con, rclass = "json")), TRUE)

  expect_equal("list" %in% class(ba_genomemaps(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_genomemaps(con, rclass = "data.frame")), TRUE)
  expect_equal("ba_genomemaps" %in% class(ba_genomemaps(con )), TRUE)
})


}
