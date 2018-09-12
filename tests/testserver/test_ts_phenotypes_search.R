context("ts phenotypes_search")

con <- ba_db()$testserver


test_that(" are present", {

  res <- ba_phenotypes_search(con = con )
  expect_true(nrow(res) == 154)

})

test_that(" out formats work", {

  out <- ba_phenotypes_search(con = con, pageSize = 1,
                              observationVariableDbIds = "MO_123:100002",
                              rclass = "tibble")
  expect_true("tbl_df" %in% class(out))



})



