context("print methods")


test_that("Parameters work", {

  expect_output({
    print(ba_db())
  })

  expect_output({
    print(ba_db()$testserver)
  })


})

