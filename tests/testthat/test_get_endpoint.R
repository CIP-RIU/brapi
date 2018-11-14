context("get_endpoint")


test_that("Parameters work", {

  expect_true({
    brapi:::get_endpoint("base") ==  "base"
  })

  expect_true({
    brapi:::get_endpoint("base", x = "x") ==  "base?x=x"
  })

  expect_true({
    brapi:::get_endpoint("base", x = "x", y = TRUE) ==  "base?x=x&y=true"
  })

  expect_true({
    brapi:::get_endpoint("base", x = "x", y = TRUE, z = 1:3) ==  "base?x=x&y=true&z=1,2,3"
  })

  expect_true({
    brapi:::get_endpoint("base", x = NA) ==  "base"
  })

  expect_error({
    brapi:::get_endpoint("base", "1")
  })

  expect_true({
    brapi:::get_endpoint("base", observationLevel = "any") == "base"
  })

})

