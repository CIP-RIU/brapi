context("paging")


test_that("Parameters work", {

  expect_error({
    brapi:::check_paging(NULL, 1)
  })

  expect_error({
    brapi:::check_paging(1, NULL)
  })

  expect_error({
    brapi:::check_paging("1", 1)
  })

  expect_error({
    brapi:::check_paging(2, "1")
  })

  expect_error({
    brapi:::check_paging(0, 1)
  })

  expect_error({
    brapi:::check_paging(1, -1)
  })



})

