context("check_character")


test_that("Parameters work", {

  expect_error({
    brapi:::check_character(1)
  })

  expect_error({
    brapi:::check_character(TRUE)
  })

  expect_error({
    brapi:::check_character(" ", FALSE)
  })

  expect_error({
    brapi:::check_character(1:10)
  })

  expect_silent({
    brapi:::check_character("a", b = "b")
  })

})

