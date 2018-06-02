context("check_ba")


test_that("Parameters work", {

  expect_error({
    brapi:::check_ba(secure = "")
  })

  expect_error({
    brapi:::check_ba(protocol = "http")
  })

  expect_error({
    brapi:::check_ba(db = 127)
  })

  expect_error({
    brapi:::check_ba(port = 0)
  })

  expect_error({
    brapi:::check_ba(apipath = NA)
  })

  expect_error({
    brapi:::check_ba(crop = TRUE)
  })

  expect_error({
    brapi:::check_ba(multicrop = "FALSE")
  })

  expect_error({
    brapi:::check_ba(user = NULL)
  })

  expect_error({
    brapi:::check_ba(password = NA)
  })

  expect_error({
    brapi:::check_ba(token = NA)
  })

  expect_error({
    brapi:::check_ba(granttype = NA)
  })

  expect_error({
    brapi:::check_ba(clientid = NA)
  })

  expect_error({
    brapi:::check_ba(bms = "FALSE")
  })


})

