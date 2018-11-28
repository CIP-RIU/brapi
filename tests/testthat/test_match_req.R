context("match_req")


test_that("Only one parameter is returned", {

  expect_true({
    brapi:::match_req(c("tibble", "data.frame",
                        "list", "json")) == "tibble"
  })

})

test_that("A parameter is returned", {

  expect_true({
    brapi:::match_req( "json") == "json"
  })

})

