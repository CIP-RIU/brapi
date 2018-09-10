context("databases")

test_that("access to internet works", {

  brapi:::skip_if_local()
  skip_on_cran()

  test_dir("../internet")

})

test_that("all checks against testserver work", {

  brapi:::skip_if_local()
  skip_on_cran()

  test_dir("../testserver")

})

test_that("all checks against sweetpotatobase work", {

  brapi:::skip_if_local()
  skip_on_cran()

  test_dir("../sweetpotatobase")

})
