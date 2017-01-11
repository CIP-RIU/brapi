source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'observationLevels'")

  con = connect(secure = FALSE)


test_that("ObservationsLevels are listed.", {
  expect_equal(length(studies_observationlevels(con, rclass = "list")), 2)
  expect_equal(studies_observationlevels(con, rclass = "vector")[1], "plant")
  expect_equal(studies_observationlevels(con, rclass = "vector")[2], "plot")
})


test_that("ObservationsLevels has correct classes.", {
  expect_equal("brapi_studies_observationlevels" %in% class(studies_observationlevels(con)), TRUE)
})



}
