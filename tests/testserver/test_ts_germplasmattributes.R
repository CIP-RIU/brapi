context("ts germplasm attributes")

con <- ba_db()$testserver

test_that("  are present", {

  expect_error({
    ba_germplasm_attributes(con = con)
  })

  expect_error({
    ba_germplasm_attributes(con = con, germplasmDbId = "1", attributeList = "1")
  })

  res <- ba_germplasm_attributes(con = con, germplasmDbId = "1")
  expect_that(nrow(res) == 5, is_true())

})

test_that("  out formats work", {

  res <- ba_germplasm_attributes(con = con, germplasmDbId = "1", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_germplasm_attributes(con = con, germplasmDbId = "1", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_germplasm_attributes(con = con, germplasmDbId = "1", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})
