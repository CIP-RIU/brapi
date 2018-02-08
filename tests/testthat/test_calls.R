
con <- ba_db()$sweetpotatobase

test_that("Calls are present", {

  res <- ba_calls(con = con)
  expect_that(nrow(res) == 42, is_true())

})

test_that("Calls output formats work", {

  res <- ba_calls(con = con, rclass = "data.frame")
  expect_that("data.frame" %in% class(res), is_true())

})
