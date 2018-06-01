context("message")


test_that("Parameters work", {
  expect_true("" == brapi:::ba_message(NULL))

  ba_show_info(TRUE)
  expect_message(brapi:::ba_message("Hi"))

  ba_show_info(FALSE)
  expect_true("" == brapi:::ba_message("Hi"))
})

