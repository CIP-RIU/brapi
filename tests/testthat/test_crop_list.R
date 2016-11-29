
context("Testing the call 'crops'")

brapi <<- list(
  crop = "sweetpotato",
  db = '127.0.0.1',
  port = 2021,
  user = "rsimon",
  password = "password",
  session = "",
  protocol = "http://"
)

test_that("Crops are listed.", {
  expect_equal(length(brapi::crops_list()), 4)
  expect_equal(brapi::crops_list()[1], "cassava")
  expect_equal(brapi::crops_list()[2], "potato")
  expect_equal(brapi::crops_list()[3], "sweetpotato")
  expect_equal(brapi::crops_list()[4], "yam")
})
