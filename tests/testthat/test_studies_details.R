source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id'")

  con <- connect(secure = FALSE)

test_that("Studies are listed.", {
  expect_equal(length(studies_details(con, 1, rclass = "list")), 2)
  expect_equal(nrow(studies_details(con, 1, rclass = "data.frame")), 2)
  expect_equal(nrow(studies_details(con, 1, rclass = "tibble")), 2)
})


test_that("With varying numbers of contacts", {
  expect_equal(nrow(studies_details(con, 1)), 2)
  expect_equal(ncol(studies_details(con, 1)), 36)
  expect_equal(nrow(studies_details(con, 11)), 1)
  expect_equal(ncol(studies_details(con, 11)), 22)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(studies_details(con, 1, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(studies_details(con, 1, rclass = "json")), TRUE)
  expect_equal("list" %in% class(studies_details(con, 1, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(studies_details(con, 1, rclass = "data.frame")), TRUE)
  expect_equal("brapi_studies_details" %in% class(studies_details(con, 1 )), TRUE)
})

}
