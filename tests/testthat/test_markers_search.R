source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'markers'")

  con <- ba_connect(secure = FALSE)

test_that("Marker search basics.", {
  expect_equal(ba_markers_search(con, "*", matchMethod = "wildcard") %>% nrow, 5)
  expect_equal(ba_markers_search(con, "*", matchMethod = "wildcard") %>% ncol, 6)
})

test_that("Match method.", {
  expect_equal(ba_markers_search(con, "a_01_10001", matchMethod = "exact") %>% nrow, 1)
  expect_equal(ba_markers_search(con, "A_01_10001", matchMethod = "case_insensitive") %>% nrow, 1)
  expect_equal(ba_markers_search(con, "?_01_1000?", matchMethod = "wildcard") %>% nrow, 2)

})

test_that("type", {
  expect_equal(ba_markers_search(con, "*", matchMethod = "wildcard", type = "SNP") %>% nrow, 3)
  expect_equal(ba_markers_search(con, "*", matchMethod = "wildcard", type = "Dart") %>% nrow, 2)
})

test_that("rclass", {
  expect_equal("json" %in% class(ba_markers_search(con, "*", matchMethod = "wildcard", rclass = "json")), TRUE)
  expect_equal("list" %in% class(ba_markers_search(con, "*", matchMethod = "wildcard", rclass = "list")), TRUE)
  expect_equal( (ba_markers_search(con, "*", matchMethod = "wildcard", rclass = "data.frame") %>% class)[1], "data.frame")
  expect_equal("tbl_df" %in% class(ba_markers_search(con, "*", matchMethod = "wildcard", rclass = "tibble")), TRUE)
  expect_equal("ba_markers_search" %in% class(ba_markers_search(con, "*", matchMethod = "wildcard")), TRUE)
})

test_that("paging", {
  expect_equal( ba_markers_search(con, "*", matchMethod = "wildcard", pageSize = 1) %>% nrow, 1)
  expect_equal( ba_markers_search(con, "*", matchMethod = "wildcard", pageSize = 2) %>% nrow, 2)
  expect_equal( ba_markers_search(con, "*", matchMethod = "wildcard", pageSize = 3) %>% nrow, 3)
  expect_equal( ba_markers_search(con, "*", matchMethod = "wildcard", pageSize = 1, page = 5) %>% nrow, 1)
  expect_equal( ba_markers_search(con, "*", matchMethod = "wildcard", pageSize = 3, page = 1) %>% nrow, 2)
})

}
