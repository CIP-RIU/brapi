source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'attributes/categories'")

  con <- ba_connect(secure = FALSE)

test_that("Calls are listed.", {
  acall <- ba_germplasmattributes_categories(con, rclass = "list")
  expect_equal(length(acall), 2)
  expect_equal(length(acall$result$data), 4)
})

test_that("Parameters are tested.", {
  acall <- ba_germplasmattributes_categories(con, pageSize = 1)
  expect_equal(nrow(acall), 1)
  acall <- ba_germplasmattributes_categories(con, 0, pageSize = 2)
  expect_equal(nrow(acall), 2)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_germplasmattributes_categories(con,  rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_germplasmattributes_categories(con,  rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_germplasmattributes_categories(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_germplasmattributes_categories(con,  rclass = "data.frame")), TRUE)
  expect_equal("ba_germplasmattributes_categories" %in% class(ba_germplasmattributes_categories(con)), TRUE)
})


}
