source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'samples'")

  con <- ba_connect(secure = FALSE)
  sampleId <- "Unique-Plant-SampleId-1234567890"

test_that("Parameters are listed.", {

  expect_equal(length(ba_samples(con, sampleId, rclass = "list")), 2)
  expect_equal(nrow(ba_samples(con, sampleId, rclass = "data.frame")), 1)

  expect_error(ba_samples(con, "x"))
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_samples(con, sampleId, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_samples(con, sampleId, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_samples(con, sampleId, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_samples(con, sampleId, rclass = "data.frame")), TRUE)
  expect_equal("ba_samples" %in% class(ba_samples(con, sampleId)), TRUE)
})

}
