source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'observationLevels'")


test_that("ObservationsLevels are listed.", {
  expect_equal(length(observationLevels(rclass = "list")), 2)
  expect_equal(observationLevels(rclass = "vector")[1], "plant")
  expect_equal(observationLevels(rclass = "vector")[2], "plot")
})



}
