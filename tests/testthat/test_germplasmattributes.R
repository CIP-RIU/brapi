source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'attributes'")

  con <- connect(secure = FALSE)

test_that("Calls are listed.", {
  acall <- germplasmattributes(con, rclass = "list")
  expect_equal(length(acall), 2)
  expect_equal(length(acall$result$data), 4)
})

test_that("Parameters are tested.", {
  acall <- germplasmattributes(con, 2)
  expect_equal(nrow(acall), 1)
  acall <- germplasmattributes(con, 1)
  expect_equal(nrow(acall), 2)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(germplasmattributes(con, 1, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(germplasmattributes(con, 1, rclass = "json")), TRUE)
  expect_equal("list" %in% class(germplasmattributes(con, 1, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(germplasmattributes(con, 1,  rclass = "data.frame")), TRUE)
  expect_equal("brapi_germplasmattributes" %in% class(germplasmattributes(con, 1)), TRUE)
})


}
