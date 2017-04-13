source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id'")

  con <- ba_connect(secure = FALSE)

test_that("Studies are listed.", {
  expect_equal(length(ba_studies_details(con, "1001", rclass = "list")), 2)
  expect_equal(nrow(ba_studies_details(con, "1001", rclass = "data.frame")), 4)
  expect_equal(nrow(ba_studies_details(con, "1001", rclass = "tibble")), 4)
})


test_that("With varying numbers of contacts", {
  expect_equal(nrow(ba_studies_details(con, "1001")), 4)
  expect_equal(ncol(ba_studies_details(con, "1001")), 18)
  expect_equal(nrow(ba_studies_details(con, "1002")), 1)
  expect_equal(ncol(ba_studies_details(con, "1002")), 19)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_studies_details(con, "1001", rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_studies_details(con, "1001", rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_studies_details(con, "1001", rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_studies_details(con, "1001", rclass = "data.frame")), TRUE)
  expect_equal("ba_studies_details" %in% class(ba_studies_details(con, "1001")), TRUE)
})

}
