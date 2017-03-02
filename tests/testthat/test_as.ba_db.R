
if (check_server_status == 200) {

context("Testing the helper function as.ba_db")

test_that("Base object ok", {
  expect_equal("ba_db" %in% class(as.ba_db()), TRUE)
  expect_equal(length(as.ba_db()), 15)
})

test_that("Input parameters are checked.", {

  expect_equal(as.ba_db(secure = TRUE)$secure, TRUE)
  expect_error(as.ba_db(secure = "x"), regexpr = "a logical")
  expect_error(as.ba_db(secure = 0), regexpr = "a logical")

  expect_equal(as.ba_db(protocol = "https://")$protocol, "https://")
  expect_equal(as.ba_db(protocol = "http://")$protocol, "http://")
  expect_error(as.ba_db(protocol = "http:"), regexpr = "http://")
  expect_error(as.ba_db(protocol = "https:"), regexpr = "https://")
  expect_error(as.ba_db(protocol = "x"), regexpr = "http://")
  expect_error(as.ba_db(protocol = 0), regexpr = "http://")
  expect_error(as.ba_db(protocol = FALSE), regexpr = "http://")

  expect_equal(as.ba_db(db = "localhost")$db, "localhost")
  expect_equal(as.ba_db(db = "127.0.0.1")$db, "127.0.0.1")
  expect_error(as.ba_db(db = 1), regexpr = "character")
  expect_error(as.ba_db(db = FALSE), regexpr = "character")

  expect_equal(as.ba_db(port = 80)$port, 80)
  expect_error(as.ba_db(port = -1 ), regexpr = "numeric value")
  expect_error(as.ba_db(port = FALSE), regexpr = "numeric")

  expect_equal(as.ba_db(apipath = "www")$apipath, "www")
  expect_error(as.ba_db(apipath = 1), regexpr = "character")
  expect_error(as.ba_db(apipath = FALSE), regexpr = "character")

  expect_equal(as.ba_db(multicrop = TRUE)$multicrop, TRUE)
  expect_error(as.ba_db(multicrop = "x"), regexpr = "a logical")
  expect_error(as.ba_db(multicrop = 0), regexpr = "a logical")

  expect_equal(as.ba_db(crop = "crop")$crop, "crop")
  expect_error(as.ba_db(crop = 1), regexpr = "character")
  expect_error(as.ba_db(crop = FALSE), regexpr = "character")

  expect_equal(as.ba_db(user = "user")$user, "user")
  expect_error(as.ba_db(user = 1), regexpr = "character")
  expect_error(as.ba_db(user = FALSE), regexpr = "character")

  expect_equal(as.ba_db(password = "password")$password, "password")
  expect_error(as.ba_db(password = 1), regexpr = "character")
  expect_error(as.ba_db(password = FALSE), regexpr = "character")

  expect_equal(as.ba_db(token = "token")$token, "token")
  expect_error(as.ba_db(token = 1), regexpr = "character")
  expect_error(as.ba_db(token = FALSE), regexpr = "character")

  expect_equal(as.ba_db(granttype = "password")$granttype, "password")
  expect_error(as.ba_db(granttype = 1), regexpr = "character")
  expect_error(as.ba_db(granttype = FALSE), regexpr = "character")

  expect_equal(as.ba_db(clientid  = "rbrapi")$clientid, "rbrapi")
  expect_error(as.ba_db(clientid = 1), regexpr = "character")
  expect_error(as.ba_db(clientid = FALSE), regexpr = "character")

  expect_equal(as.ba_db(bms = TRUE)$bms, TRUE)
  expect_error(as.ba_db(bms = "x"), regexpr = "logical")
  expect_error(as.ba_db(bms = 10), regexpr = "logical")
})

}
