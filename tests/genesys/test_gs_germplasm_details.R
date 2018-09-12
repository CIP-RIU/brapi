context("gs germplasm_details")

con <- ba_db()$genesys

test_that("Germplasm_details results are present", {

  res <- ba_germplasm_details(con, germplasmDbId = "cd8c1217-4503-4859-813b-32251f0c8eba")
  expect_that(nrow(res) >= 1, is_true())

})


test_that("Out formats work", {

  res <- ba_germplasm_details(con = con, germplasmDbId = "cd8c1217-4503-4859-813b-32251f0c8eba", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_germplasm_details(con = con, germplasmDbId = "cd8c1217-4503-4859-813b-32251f0c8eba", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_germplasm_details(con = con, germplasmDbId = "cd8c1217-4503-4859-813b-32251f0c8eba", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})
