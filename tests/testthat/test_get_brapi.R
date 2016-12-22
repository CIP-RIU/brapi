source("check_server_status.R")

if (check_server_status == 200) {

context("Testing the helper function 'get_brapi'")


test_that("Parameters are tested.", {
  obr <- get_brapi()

  # nbr <- as.brapi_db(multi = TRUE)
  # res <- connect(nbr)
  # expect_equal(get_brapi())

  # TODO: change start script from sourcing to function with port parameter
  # TODO: for future testing: have two test servers running
  # TODO: have on the empty call allowance for multi-crop

 })

}
