source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'allelematrix-search'")

test_that("Basics works", {
  expect_equal(nrow(markerprofiles_alleles(3)), 12)
  expect_equal(ncol(markerprofiles_alleles(3)), 2)
})


test_that("paging", {
  expect_equal(markerprofiles_alleles(3, pageSize = 4, rclass = "tibble") %>% nrow, 4)
  expect_equal(markerprofiles_alleles(3, pageSize = 4, page = 3, rclass = "tibble") %>% nrow, 4)
})


test_that("rclass", {
  expect_equal(class(markerprofiles_alleles(3, rclass = "tibble"))[1], "tbl_df")
  expect_equal(class(markerprofiles_alleles(3, rclass = "data.frame"))[1], "data.frame")
  expect_equal(class(markerprofiles_alleles(3, rclass = "list"))[1], "list")
  expect_equal(class(markerprofiles_alleles(3, rclass = "json"))[1], "json")
  expect_equal("brapi_markerprofiles_alleles" %in% class(markerprofiles_alleles(3)), TRUE )
})


}
