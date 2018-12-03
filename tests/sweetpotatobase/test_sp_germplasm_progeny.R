context("sp germplasm_progeny")

con <- ba_db()$sweetpotatobase

test_that("Germplasm_progeny results are present", {

  res <- ba_germplasm_progeny(con = con, germplasmDbId = "103412")
  expect_that(nrow(res) == 1, is_true())
  expect_that(ncol(res) >= 0, is_true())

})

test_that("out formats work", {

  res <- ba_germplasm_progeny(con = con, germplasmDbId = "103412", rclass = "json")
  expect_that("json" %in% class(res), is_true())

  res <- ba_germplasm_progeny(con = con, germplasmDbId = "103412", rclass = "list")
  expect_that("list" %in% class(res), is_true())

  res <- ba_germplasm_progeny(con = con, germplasmDbId = "103412", rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})

