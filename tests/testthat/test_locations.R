source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'locations'")

  con <- ba_connect(secure = FALSE)

test_that("Locations are listed.", {
  expect_equal(length(ba_locations(con, rclass = "list")), 2)
  expect_equal(nrow(ba_locations(con, rclass = "data.frame")), 17)
  expect_equal(nrow(ba_locations(con, "field")), 6)
})

test_that("Special cases", {
  # bms <- ba_db()$bms_test
  # try({
  #   bms <- ba_authenticate(bms)
  #
  #   expect_equal(ba_locations(bms), TRUE)
  # })
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_locations(con,  rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_locations(con,  rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_locations(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_locations(con,  rclass = "data.frame")), TRUE)
  expect_equal("ba_locations" %in% class(ba_locations(con)), TRUE)
})

}
