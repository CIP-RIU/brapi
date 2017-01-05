source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/observationunits'")

test_that("Basics.", {
  expect_equal(length(studies_observationunits(rclass = "list")), 2)
  expect_equal(nrow(studies_observationunits(rclass = "data.frame")), 3)
})

test_that("Parameters", {
  expect_equal(nrow(studies_observationunits(1)), 3)
  expect_equal(nrow(studies_observationunits(2)), 4)
  expect_equal("plotNumber" %in% colnames(studies_observationunits(1, "plot")), TRUE)
  expect_equal("plantNumber" %in% colnames(studies_observationunits(1, "plant")), TRUE)
})


test_that("Classes", {
  expect_equal("json" %in% class(studies_observationunits(rclass = "json")), TRUE)
  expect_equal("list" %in% class(studies_observationunits(rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(studies_observationunits(rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(studies_observationunits()), TRUE)
  expect_equal("brapi_studies_observationunits" %in% class(studies_observationunits()), TRUE)
})

}

