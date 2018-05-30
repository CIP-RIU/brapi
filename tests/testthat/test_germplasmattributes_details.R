context("germplasmattributes_details")

con <- ba_db()$testserver

test_that("  are present", {

  res <- ba_germplasmattributes_details(con = con, germplasmDbId = "1" )
  expect_that(nrow(res) == 10, is_true())

})
