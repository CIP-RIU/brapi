context("rclass")


test_that("Parameters work", {

  expect_error({
    brapi:::check_rclass(NULL)
  })

})

