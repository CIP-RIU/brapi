source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'phenotype-search'")

  con <- ba_connect(secure = FALSE)

test_that("Basics.", {
  expect_equal(length(ba_phenotypes_search(con, "1", rclass = "list")), 2)
  expect_equal(nrow(ba_phenotypes_search(con, "1", rclass = "data.frame")), 4)
})

test_that("Parameters", {
   expect_equal(nrow(ba_phenotypes_search(con, "1")), 4)
   expect_equal(nrow(ba_phenotypes_search(con, "2")), 1)
})


test_that("Classes", {
  expect_equal("json" %in% class(ba_phenotypes_search(con, "1", rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_phenotypes_search(con, "1", rclass = "list")), TRUE)
  expect_equal("data.frame" %in% class(ba_phenotypes_search(con, "1", rclass = "data.frame")), TRUE)
  expect_equal("tbl_df" %in% class(ba_phenotypes_search(con, "1")), TRUE)
  expect_equal("ba_phenotypes_search" %in% class(ba_phenotypes_search(con, "1", rclass = "json")), TRUE)
})

}
