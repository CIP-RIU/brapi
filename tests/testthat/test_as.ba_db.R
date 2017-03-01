
if (check_server_status == 200) {

context("Testing the helper function as.ba_db")

test_that("Calls are listed.", {
  expect_equal("ba_db" %in% class(as.ba_db()), TRUE)
  expect_equal(length(as.ba_db()), 15)
})


}
