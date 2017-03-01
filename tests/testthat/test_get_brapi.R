source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function 'get_brapi'")


test_that("Parameters are tested.", {
  obr <- get_brapi()
 })

test_that("Special cases tested.", {
  brapi <- list(secure = TRUE, multicrop = TRUE, protocol = "http://", db = "test",
                port = 80, apipath = "apipath", crop = "crop")
  expect_equal(get_brapi(brapi), "https://test/apipath/crop/brapi/v1/")
})

}
