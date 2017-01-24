source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'programs'")

  con <- connect(secure = FALSE)


test_that("Calls are listed.", {
  expect_equal(length(programs(con, rclass = "list")), 2)
  expect_equal(nrow(programs(con)), 6)
})

test_that("Parameters are tested.", {
  expect_equal(length(programs(con, page = 0, pageSize = 1, rclass = "list")$result$data), 1)
  expect_equal(length(programs(con, page = 0, pageSize = 2, rclass = "list")$result$data), 2)
  expect_equal(length(programs(con, page = 1, pageSize = 1, rclass = "list")$result$data), 1)
})

test_that("Filters.", {
  expect_equal(nrow(programs(con, programName = "Program 1")), 1)
  expect_equal(nrow(programs(con, abbreviation = "P2")), 1)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(programs(con, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(programs(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(programs(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(programs(con, rclass = "data.frame")), TRUE)
  expect_equal("brapi_programs" %in% class(programs(con )), TRUE)
})


}
