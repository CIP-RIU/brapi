context("phenotypes_search")

con <- ba_db()$musabase
res <- ba_phenotypes_search(con = con, pageSize = 1,
                            observationVariableDbIds = "77809",
                            rclass = "json")

test_that(" are present", {


  expect_true('ba_phenotypes_search' %in% class(res))

})

test_that(" out formats work", {

  out <- res %>% brapi:::baps2rclass("tibble")
  expect_true("tbl_df" %in% class(out))

  out <- res %>% brapi:::baps2rclass("list")
  expect_true("list" %in% class(out))

  out <- res %>% brapi:::baps2rclass("data.frame")
  expect_true("data.frame" %in% class(out))

})



