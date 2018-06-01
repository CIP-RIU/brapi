context("ba_connect")


test_that("Parameters work", {

  res <- ba_connect(db = "test-server.brapi.org", crop = "crop1")
  expect_true("ba_con" %in% class(res))

})

