source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'markerprofiles'")

test_that("Basics works", {
  expect_equal(nrow(markerprofiles(3)), 1)
  expect_equal(ncol(markerprofiles(3)), 8)
})

test_that("Parmaeter", {
  expect_equal(markerprofiles(germplasmDbId = 3) %>% nrow, 1)
  expect_equal(markerprofiles(extractDbId = 1) %>% nrow, 1)
  expect_equal(markerprofiles(studyDbId = 1) %>% nrow, 1)
  expect_equal(markerprofiles(methodDbId = "GBS") %>% nrow, 1)
  expect_equal(markerprofiles(sampleDbId = 33) %>% nrow, 1)
})

test_that("paging", {
  expect_equal(markerprofiles(3, pageSize = 1, rclass = "tibble") %>% nrow, 1)

})


test_that("rclass", {
  expect_equal(class(markerprofiles(3, rclass = "tibble"))[1], "tbl_df")
  expect_equal(class(markerprofiles(3, rclass = "data.frame"))[1], "data.frame")
  expect_equal(class(markerprofiles(3, rclass = "list"))[1], "list")
  expect_equal(class(markerprofiles(3, rclass = "json"))[1], "json")

})


}
