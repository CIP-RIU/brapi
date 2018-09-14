context("sp phenotypes_search_post")

con <- ba_db()$sweetpotatobase


test_that(" are present", {

  #skip("Very slow implementation")

  res <- ba_phenotypes_search_post(con = con, pageSize = 1, studyDbIds = "136")
  expect_true(nrow(res) > 1)

})

test_that(" out formats work", {

  #skip("Very slow implementation")

  out <- ba_phenotypes_search_post(con = con, pageSize = 1, studyDbIds = "136",
                              rclass = "tibble")
  expect_true("tbl_df" %in% class(out))



})



