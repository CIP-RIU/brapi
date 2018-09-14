context("ts vendor_specifications")

con <- ba_db()$testserver

test_that("Vendor specifications are present", {

  res <- ba_vendor_specifications(con = con)
  expect_that("list" %in% class(res), is_true())

  res <- ba_vendor_specifications(con = con, rclass = "json")
  expect_that("json" %in% class(res), is_true())

})

