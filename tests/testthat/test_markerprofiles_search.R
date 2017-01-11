source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'markerprofiles'")

  con = connect(secure = FALSE)

test_that("Basics works", {
  expect_equal(nrow(markerprofiles_search(con, 3)), 1)
  expect_equal(ncol(markerprofiles_search(con, 3)), 8)
})

test_that("Parmaeter", {
  expect_equal(markerprofiles_search(con, germplasmDbId = 3) %>% nrow, 1)
  expect_equal(markerprofiles_search(con, extractDbId = 1) %>% nrow, 1)
  expect_equal(markerprofiles_search(con, studyDbId = 1) %>% nrow, 1)
  expect_equal(markerprofiles_search(con, methodDbId = "GBS") %>% nrow, 1)
  expect_equal(markerprofiles_search(con, sampleDbId = 33) %>% nrow, 1)
})


test_that("POST", {
  expect_equal(markerprofiles_search(con, 3:1000) %>% nrow, 2)
})


test_that("extract", {
  expect_equal(markerprofiles_search(con, 3:1000, extractDbId = 1) %>% nrow, 1)
})


test_that("paging", {
  expect_equal(markerprofiles_search(con, 3, pageSize = 1, rclass = "tibble") %>% nrow, 1)

})


test_that("rclass", {
  expect_equal(class(markerprofiles_search(con, 3, rclass = "tibble"))[1], "tbl_df")
  expect_equal(class(markerprofiles_search(con, 3, rclass = "data.frame"))[1], "data.frame")
  expect_equal(class(markerprofiles_search(con, 3, rclass = "list"))[1], "list")
  expect_equal(class(markerprofiles_search(con, 3, rclass = "json"))[1], "json")
  expect_equal("brapi_markerprofiles_search" %in% class(markerprofiles_search(con, 3)), TRUE)
})


}
