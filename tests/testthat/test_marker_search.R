source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the path 'marker_search'")

test_that("Marker search basics.", {
  expect_equal(marker_search("*", matchMethod = "wildcard") %>% nrow, 5)
  expect_equal(marker_search("*", matchMethod = "wildcard") %>% ncol, 6)
})

test_that("Match method.", {
  expect_equal(marker_search("a_01_10001", matchMethod = "exact") %>% nrow, 1)
  expect_equal(marker_search("A_01_10001", matchMethod = "case_insensitive") %>% nrow, 1)
  expect_equal(marker_search("?_01_1000?", matchMethod = "wildcard") %>% nrow, 2)

})

test_that("type", {
  expect_equal(marker_search("*", matchMethod = "wildcard", type = "SNP") %>% nrow, 3)
  expect_equal(marker_search("*", matchMethod = "wildcard", type = "Dart") %>% nrow, 2)
})

test_that("include", {
  # Implement better response processing! synonyms and refAlts need revision
  #expect_equal(marker_search("*", matchMethod = "wildcard", include="") %>% ncol, 5)

})


test_that("rclass", {
  expect_equal(marker_search("*", matchMethod = "wildcard", rclass = "json") %>% class, 'json')
  expect_equal(marker_search("*", matchMethod = "wildcard", rclass = "list") %>% class, 'list')
  expect_equal(marker_search("*", matchMethod = "wildcard", rclass = "data.frame") %>% class, 'data.frame')
  expect_equal(class(marker_search("*", matchMethod = "wildcard", rclass = "tibble"))[1], 'tbl_df')
})

test_that("paging", {
  expect_equal(marker_search("*", matchMethod = "wildcard", pageSize = 1) %>% nrow, 1)
  expect_equal(marker_search("*", matchMethod = "wildcard", pageSize = 2) %>% nrow, 2)
  expect_equal(marker_search("*", matchMethod = "wildcard", pageSize = 3) %>% nrow, 3)

  expect_equal(marker_search("*", matchMethod = "wildcard", pageSize = 1, page = 5) %>% nrow, 1)
  expect_equal(marker_search("*", matchMethod = "wildcard", pageSize = 3, page = 1) %>% nrow, 2)
})

}
