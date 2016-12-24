source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}/markerprofiles'")


test_that("Basic return object is ok.", {
  acall = brapi::germplasm_markerprofiles(0, "list")
  expect_equal(length(acall), 2)
  expect_equal(names(acall)[1], "metadata")
  expect_equal(names(acall)[2], "result")
})

test_that("Metadata object is ok.", {
  metadata = brapi::germplasm_markerprofiles(0, "list")$metadata
  expect_equal(names(metadata)[1], "pagination")
  expect_equal(names(metadata)[2], "status")
  expect_equal(names(metadata)[3], "data")
  #expect_equal(capture.output(metadata$pagination), "named list()")
  expect_equal(class(metadata[2]), "list")
  expect_equal(class(metadata[3]), "list")
})

test_that("Returned tibble is ok.", {
  expect_equal(nrow(germplasm_markerprofiles(3)), 3)
})

test_that("Returned data.frame is ok.", {
  expect_equal(nrow(germplasm_markerprofiles(3, "data.frame")), 3)
})


test_that("Parameters are tested.", {
  expect_equal(length(brapi::germplasm_markerprofiles(3, "list")$result), 2)
  expect_equal(length(brapi::germplasm_markerprofiles(3, "list")$result$markerProfiles), 3)
  expect_equal(length(brapi::germplasm_markerprofiles(3, "vector")), 3)
 })

}
