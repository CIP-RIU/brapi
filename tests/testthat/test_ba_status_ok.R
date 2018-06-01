context("ba_status_ok")


test_that("Parameters work", {

  resp = list()
  resp$status_code = 400

  expect_error({
    res <- brapi:::is.ba_status_ok(resp)
  })

  resp$status_code = 401

  expect_error({
    res <- brapi:::is.ba_status_ok(resp)
  })

  resp$status_code = 403

  expect_error({
    res <- brapi:::is.ba_status_ok(resp)
  })

  resp$status_code = 404

  expect_error({
    res <- brapi:::is.ba_status_ok(resp)
  })

  resp$status_code = 500

  expect_error({
    res <- brapi:::is.ba_status_ok(resp)
  })

  resp$status_code = 501

  expect_error({
    res <- brapi:::is.ba_status_ok(resp)
  })

  resp$status_code = 911

  expect_false({
    brapi:::is.ba_status_ok(resp)
  })
})

