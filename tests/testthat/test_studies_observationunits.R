source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'studies/id/observationunits'")

  con <- connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(studies_observationunits(con, rclass = "list")), 2)
  expect_equal(nrow(studies_observationunits(con, rclass = "data.frame")), 3)
})

test_that("Parameters", {
  expect_equal(nrow(studies_observationunits(con, 1)), 3)
  expect_equal(nrow(studies_observationunits(con, 2)), 4)
  expect_equal("plotNumber" %in% colnames(studies_observationunits(con, 1, "plot")), TRUE)
  expect_equal("plantNumber" %in% colnames(studies_observationunits(con, 1, "plant")), TRUE)
})


test_that("Classes", {
  expect_equal("json" %in% class(studies_observationunits(con, rclass = "json")), TRUE)
  expect_equal("list" %in% class(studies_observationunits(con, rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(studies_observationunits(con, rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(studies_observationunits(con)), TRUE)
  expect_equal("brapi_studies_observationunits" %in% class(studies_observationunits(con)), TRUE)
})

}
