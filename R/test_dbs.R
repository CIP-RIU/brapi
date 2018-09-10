test_dbs <- function(resources = c("internet",
                                   "testserver",
                                   "sweetpotatobase")) {
  if ("internet" %in% resources) {
    testthat::test_dir("tests/internet")
  }
  if ("testserver" %in% resources) {
    testthat::test_dir("tests/testserver")
  }
  if ("sweetpotatobase" %in% resources) {
    testthat::test_dir("tests/sweetpotatobase")
  }
}
