source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies-search'")

  con <- ba_connect(secure = FALSE)

test_that("Studies are listed.", {
  expect_equal(length(ba_studies_search(con, rclass = "list")), 2)
  expect_equal(nrow(ba_studies_search(con, rclass = "data.frame")), 11)
  expect_equal(nrow(ba_studies_search(con, rclass = "tibble")), 11)
})

test_that("Study type.", {
  expect_equal(nrow(ba_studies_search(con, "MET study")), 3)
})

test_that("POST.", {
  expect_equal(nrow(ba_studies_search(con, germplasmDbIds = 1:1000)), 11)
})


test_that("Paging.", {
  expect_equal(nrow(ba_studies_search(con, pageSize = 1)), 1)
  expect_equal(nrow(ba_studies_search(con, pageSize = 3)), 3)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_studies_search(con, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_studies_search(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_studies_search(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_studies_search(con, rclass = "data.frame")), TRUE)
  expect_equal("ba_studies_search" %in% class(ba_studies_search(con )), TRUE)
})

}
