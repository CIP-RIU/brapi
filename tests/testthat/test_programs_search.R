source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'programs_search'")

  con <- ba_connect(secure = FALSE)


test_that("Calls are listed.", {
  expect_equal(length(ba_programs_search(con, rclass = "list")), 2)
  expect_equal(nrow(ba_programs_search(con)), 6)
})


test_that("Filters.", {
  expect_equal(nrow(ba_programs_search(con, name = "Program 1")), 1)
  expect_equal(nrow(ba_programs_search(con, abbreviation = "P2")), 1)
  expect_equal(nrow(ba_programs_search(con, programDbId = "1")), 1)
  expect_equal(nrow(ba_programs_search(con, objective = "XYZ")), 2)
  expect_equal(nrow(ba_programs_search(con, leadPerson = "G. Gain")), 1)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_programs_search(con, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_programs_search(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_programs_search(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_programs_search(con, rclass = "data.frame")), TRUE)
  expect_equal("ba_programs_search" %in% class(ba_programs_search(con )), TRUE)
})


}
