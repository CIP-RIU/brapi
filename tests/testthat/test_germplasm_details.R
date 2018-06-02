context("germplasm_details")

con <- ba_db()$testserver

test_that("Germplasm_details results are present", {

  res <- ba_germplasm_details(con = con, germplasmDbId = "1")
  expect_that(nrow(res) == 4, is_true())

})


test_that("Out formats worl", {

  res <- ba_germplasm_details(con = con, germplasmDbId = "1", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_germplasm_details(con = con, germplasmDbId = "1", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_germplasm_details(con = con, germplasmDbId = "1", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})
