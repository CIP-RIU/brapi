source("check_server_status.R")

if (check_server_status == 200) {

  context("Testing helper 'ba_connect'")

  test_that("Parameters are checked.", {

    expect_equal(ba_connect(secure = TRUE)$secure, TRUE)
    expect_error(ba_connect(secure = "x"), regexpr = "a logical")
    expect_error(ba_connect(secure = 0), regexpr = "a logical")

    expect_equal(ba_connect(protocol = "https://")$protocol, "https://")
    expect_equal(ba_connect(protocol = "http://")$protocol, "http://")
    expect_error(ba_connect(protocol = "http:"), regexpr = "http://")
    expect_error(ba_connect(protocol = "https:"), regexpr = "https://")
    expect_error(ba_connect(protocol = "x"), regexpr = "http://")
    expect_error(ba_connect(protocol = 0), regexpr = "http://")
    expect_error(ba_connect(protocol = FALSE), regexpr = "http://")

    expect_equal(ba_connect(db = "localhost")$db, "localhost")
    expect_equal(ba_connect(db = "127.0.0.1")$db, "127.0.0.1")
    expect_error(ba_connect(db = 1), regexpr = "character")
    expect_error(ba_connect(db = FALSE), regexpr = "character")

    expect_equal(ba_connect(port = 80)$port, 80)
    expect_error(ba_connect(port = -1 ), regexpr = "numeric value")
    expect_error(ba_connect(port = FALSE), regexpr = "numeric")

    expect_equal(ba_connect(apipath = "www")$apipath, "www")
    expect_error(ba_connect(apipath = 1), regexpr = "character")
    expect_error(ba_connect(apipath = FALSE), regexpr = "character")

    expect_equal(ba_connect(multicrop = TRUE)$multicrop, TRUE)
    expect_error(ba_connect(multicrop = "x"), regexpr = "a logical")
    expect_error(ba_connect(multicrop = 0), regexpr = "a logical")

    expect_equal(ba_connect(crop = "crop")$crop, "crop")
    expect_error(ba_connect(crop = 1), regexpr = "character")
    expect_error(ba_connect(crop = FALSE), regexpr = "character")

    expect_equal(ba_connect(user = "user")$user, "user")
    expect_error(ba_connect(user = 1), regexpr = "character")
    expect_error(ba_connect(user = FALSE), regexpr = "character")

    expect_equal(ba_connect(password = "password")$password, "password")
    expect_error(ba_connect(password = 1), regexpr = "character")
    expect_error(ba_connect(password = FALSE), regexpr = "character")

    expect_equal(ba_connect(token = "token")$token, "token")
    expect_error(ba_connect(token = 1), regexpr = "character")
    expect_error(ba_connect(token = FALSE), regexpr = "character")

    expect_equal(ba_connect(granttype = "password")$granttype, "password")
    expect_error(ba_connect(granttype = 1), regexpr = "character")
    expect_error(ba_connect(granttype = FALSE), regexpr = "character")

    expect_equal(ba_connect(clientid  = "rbrapi")$clientid, "rbrapi")
    expect_error(ba_connect(clientid = 1), regexpr = "character")
    expect_error(ba_connect(clientid = FALSE), regexpr = "character")

    expect_equal(ba_connect(bms = TRUE)$bms, TRUE)
    expect_error(ba_connect(bms = "x"), regexpr = "logical")
    expect_error(ba_connect(bms = 0), regexpr = "logical")
  })

}
