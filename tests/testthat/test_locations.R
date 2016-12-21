source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'locations'")

test_that("Locations are listed.", {
  expect_equal(length(locations(rclass = "list")), 2)
  expect_equal(nrow(locations(rclass = "data.frame")), 17)
  expect_equal(nrow(locations("field")), 6)
})


}

