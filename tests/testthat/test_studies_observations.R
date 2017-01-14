source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/observations'")

  con <- connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(studies_observations(con, rclass = "list")), 2)
  expect_equal(nrow(studies_observations(con, rclass = "data.frame")), 3)
})


test_that("Paging", {
  expect_equal(nrow(studies_observations(con, pageSize = 1)), 1)
  expect_equal(nrow(studies_observations(con, pageSize = 1, page = 2)), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(studies_observations(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(studies_observations(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(studies_observations(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(studies_observations(con )), TRUE)
  expect_equal("brapi_studies_observations" %in% class(studies_observations(con)), TRUE)
})

}
