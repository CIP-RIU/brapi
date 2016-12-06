source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'germplasm/{id}/markerprofiles'")


test_that("Calls are listed.", {
  expect_equal(length(brapi::germplasm_markerprofiles()), 2)
})

test_that("Parameters are tested.", {
  expect_equal(length(brapi::germplasm_markerprofiles(3)$result), 2)
  expect_equal(length(brapi::germplasm_markerprofiles(3)$result$markerProfiles), 3)
  expect_equal(length(brapi::germplasm_markerprofiles(3, "vector")), 3)
 })

}
