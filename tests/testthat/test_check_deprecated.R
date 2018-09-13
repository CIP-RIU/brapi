context("check_deprecated")


test_that("Parameters work", {

  expect_error({
    param_deprecated <- "x"
    brapi:::check_deprecated(param_deprecated, "")
  })

  param_deprecated <- NULL
  expect_true({
    brapi:::check_deprecated(param_deprecated, "")
  })

})

