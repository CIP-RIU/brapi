context("ts vendor_plates_details")

con <- ba_db()$testserver

test_that("Vendor plates details are present", {

  res <- ba_vendor_plates_details(con = con, "pl1")
  expect_that("list" %in% class(res), is_true())

  res <- ba_vendor_plates_details(con = con, "pl1", rclass = "json")
  expect_that("json" %in% class(res), is_true())

})

