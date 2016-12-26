source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'allelematrix-search'")

test_that("Basics works", {
  expect_equal(nrow(allelematrix_search(3)), 12)
  expect_equal(ncol(allelematrix_search(3)), 2)
})

test_that("Basics works POST", {
  expect_equal(nrow(allelematrix_search(3, method = "POST")), 12)
  expect_equal(ncol(allelematrix_search(3, method = "POST")), 2)
})


test_that("format parameter", {
  expect_equal(nrow(allelematrix_search(3, format = "csv")), 12)
  expect_equal(class(allelematrix_search(3, format = "csv"))[1], "tbl_df")

  expect_equal(nrow(allelematrix_search(3, format = "tsv")), 12)
  expect_equal(class(allelematrix_search(3, format = "tsv"))[1], "tbl_df")
})

test_that("paging", {
  expect_equal(allelematrix_search(3, pageSize = 4, rclass = "tibble") %>% nrow, 4)
  expect_equal(allelematrix_search(3, pageSize = 4, page = 3, rclass = "tibble") %>% nrow, 4)
})

test_that("rclass", {
  expect_equal(class(allelematrix_search(3, rclass = "tibble"))[1], "tbl_df")
  expect_equal(class(allelematrix_search(3, rclass = "data.frame"))[1], "data.frame")
  expect_equal(class(allelematrix_search(3, rclass = "list"))[1], "list")
  expect_equal(class(allelematrix_search(3, rclass = "json"))[1], "json")
  expect_equal("brapi_allelematrix" %in% class(allelematrix_search(3)), TRUE )
})


}
