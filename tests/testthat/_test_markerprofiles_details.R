source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'markerprofiles/id'")
  con <- ba_connect(secure = FALSE)

test_that("Basics works", {
  expect_equal(nrow(ba_markerprofiles_details(con, "3")), 12)
  expect_equal(ncol(ba_markerprofiles_details(con, "3")), 2)
})


test_that("paging", {
  expect_equal(ba_markerprofiles_details(con, "3", pageSize = 4, rclass = "tibble") %>% nrow, 4)
  expect_equal(ba_markerprofiles_details(con, "3", pageSize = 4, page = 3, rclass = "tibble") %>% nrow, 4)
})


test_that("rclass", {
  expect_equal(class(ba_markerprofiles_details(con, "3", rclass = "tibble"))[1], "tbl_df")
  expect_equal(class(ba_markerprofiles_details(con, "3", rclass = "data.frame"))[1], "data.frame")
  expect_equal(class(ba_markerprofiles_details(con, "3", rclass = "list"))[1], "list")
  expect_equal(class(ba_markerprofiles_details(con, "3", rclass = "json"))[1], "json")
  expect_equal("ba_markerprofiles_details" %in% class(ba_markerprofiles_details(con, "3")), TRUE )
})


}
