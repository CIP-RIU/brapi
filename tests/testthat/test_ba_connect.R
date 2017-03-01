source("check_server_status.R")

if (check_server_status == 200) {

  context("Testing helper 'ba_connect'")

  test_that("Parameters are checked.", {
    expect_error(ba_connect(secure = "x"))
    expect_error(ba_connect(db = 0))
    expect_error(ba_connect(port = "x"))
    expect_error(ba_connect(bms = "x"))
    expect_error(ba_connect(apipath = 0))
    expect_error(ba_connect(crop = 0))
    expect_error(ba_connect(multicrop = "x"))
    expect_error(ba_connect(user = 0))
    expect_error(ba_connect(password = 0))
    expect_error(ba_connect(token = 0))
    expect_equal(ba_connect(bms = TRUE)$multicrop == TRUE, TRUE)
  })

}
