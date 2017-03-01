source("check_server_status.R")

if (check_server_status == 200) {

context("Testing print methods")

test_that("print output for 'con'.", {
  con <- ba_connect(secure = FALSE)

  out <- capture.output( print(con) )
  expect_equal(length(out), 4)
  expect_equal(out[1], "Crop = sweetpotato")
  expect_equal(out[2], "")
  expect_equal(out[3], "Addres:Port = 127.0.0.1:2021")
  expect_equal(out[4], "User = user")
})

test_that("print output for 'ba-db'.", {
  bdb <- ba_db()

  out <- capture.output( print(bdb) )
  expect_equal(length(out), 11)
  expect_equal(out[1], "bms_test")
  expect_equal(out[11], "ttw")
})

}
