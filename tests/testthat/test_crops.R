source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'crops'")
  con <- ba_connect(secure = FALSE)

test_that("Crops are listed.", {
  expect_equal(length(ba_crops(con, rclass = "list")), 2)
  expect_equal(ba_crops(con, rclass = "vector")[1], "new crop")
})

test_that("Classes", {
  expect_equal("json" %in% class(ba_crops(con, rclass = "json")), TRUE)
  expect_equal("json" %in% class(ba_crops(con, rclass = "something")), TRUE)
  expect_equal("data.frame" %in% class(ba_crops(con, rclass = "data.frame")), TRUE)
  expect_equal("character" %in% class(ba_crops(con, rclass = "vector" )), TRUE)
  expect_equal("ba_crops" %in% class(ba_crops(con )), TRUE)
})


}
