source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'allelematrix-search'")

  con <- ba_connect(secure = FALSE)

test_that("Basics works", {
  expect_equal(nrow(ba_markerprofiles_allelematrix_search(con, "3")), 10)
  expect_equal(ncol(ba_markerprofiles_allelematrix_search(con, "3")), 2)
})

test_that("Basics works POST", {
  expect_equal(nrow(ba_markerprofiles_allelematrix_search(con, as.character(3:1000))), 20)
})


test_that("format parameter", {
  expect_equal(nrow(ba_markerprofiles_allelematrix_search(con, "3", format = "csv")), 10)
  expect_equal(class(ba_markerprofiles_allelematrix_search(con, "3", format = "csv"))[1], "tbl_df")

  expect_equal(nrow(ba_markerprofiles_allelematrix_search(con, "3", format = "tsv")), 10)
  expect_equal(class(ba_markerprofiles_allelematrix_search(con, "3", format = "tsv"))[1], "tbl_df")
})

test_that("paging", {
  expect_equal(ba_markerprofiles_allelematrix_search(con, "3", pageSize = 4, rclass = "tibble") %>% nrow, 4)
  expect_equal(ba_markerprofiles_allelematrix_search(con, "3", pageSize = 4, page = 3, rclass = "tibble") %>% nrow, 4)
})

test_that("rclass", {
  expect_equal(class(ba_markerprofiles_allelematrix_search(con, "3", rclass = "tibble"))[1], "tbl_df")
  expect_equal(class(ba_markerprofiles_allelematrix_search(con, "3", rclass = "data.frame"))[1], "data.frame")
  expect_equal(class(ba_markerprofiles_allelematrix_search(con, "3", rclass = "list"))[1], "list")
  expect_equal(class(ba_markerprofiles_allelematrix_search(con, "3", rclass = "json"))[1], "json")
  expect_equal("ba_markerprofiles_allelematrix_search" %in%
                 class(ba_markerprofiles_allelematrix_search(con, "3")), TRUE )
})


}
