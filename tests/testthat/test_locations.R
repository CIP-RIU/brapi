source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'locations'")

  con <- connect(secure = FALSE)

test_that("Locations are listed.", {
  expect_equal(length(locations(con, rclass = "list")), 2)
  expect_equal(nrow(locations(con, rclass = "data.frame")), 17)
  expect_equal(nrow(locations(con, "field")), 6)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(locations(con,  rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(locations(con,  rclass = "json")), TRUE)
  expect_equal("list" %in% class(locations(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(locations(con,  rclass = "data.frame")), TRUE)
  expect_equal("brapi_locations" %in% class(locations(con)), TRUE)
})

}
