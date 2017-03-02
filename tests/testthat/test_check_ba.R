
context("Testing the helper function check_ba")

test_that("Check parameters work.", {

  expect_error(brapi:::check_ba(bms = "x"))

})
