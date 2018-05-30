context("germplasm_search")

con <- ba_db()$testserver

test_that("Germplasm_search results are present", {

  res <- ba_germplasm_search(con = con, germplasmDbId = "1")
  expect_that(nrow(res) == 1, is_true())

})

