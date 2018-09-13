context("check_paging")


test_that("Parameters work", {

  expect_error({
    brapi:::check_paging(1, "")
  })

  expect_error({
    brapi:::check_paging("", 1)
  })

  expect_error({
    brapi:::check_paging("", "")
  })

  expect_error({
    brapi:::check_paging("x", "y")
  })

  expect_silent({
    brapi:::check_paging(1, 0)
  })

})

