source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}/markerprofiles'")

  con <- ba_connect(secure = FALSE)

test_that("Basic return object is ok.", {
  acall <- ba_germplasm_markerprofiles(con, 3, "list")
  expect_equal(length(acall), 2)
  expect_equal(names(acall)[1], "metadata")
  expect_equal(names(acall)[2], "result")
})

test_that("Metadata object is ok.", {
  metadata <- ba_germplasm_markerprofiles(con, 3, "list")$metadata
  expect_equal(names(metadata)[1], "pagination")
  expect_equal(names(metadata)[2], "status")
  expect_equal(names(metadata)[3], "datafiles")
  expect_equal(class(metadata[2]), "list")
  expect_equal(class(metadata[3]), "list")
})

test_that("Returned tibble is ok.", {
  expect_equal(nrow(ba_germplasm_markerprofiles(con, 3)), 3)
})

test_that("Returned data.frame is ok.", {
  expect_equal(nrow(ba_germplasm_markerprofiles(con, 3, "data.frame")), 3)
})


test_that("Classes", {
  expect_equal("tbl_df" %in% class(ba_germplasm_markerprofiles(con, 3, rclass = "tibble")), TRUE)
  expect_equal("json" %in% class(ba_germplasm_markerprofiles(con, 3, rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_germplasm_markerprofiles(con, 3, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_germplasm_markerprofiles(con, 3, rclass = "data.frame")), TRUE)
  expect_equal("ba_germplasm_markerprofiles" %in% class(ba_germplasm_markerprofiles(con, 3)), TRUE)
})

}
