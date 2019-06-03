
#' skip_if_local
#'
#' A helper function to minimize time consuming testing against databases locally.
#'
#' Only used within formal tests of the package.
#'
#' @return boolean
#' @export
skip_if_local <- function() {
  if ((Sys.getenv("NOT_CRAN"))) {
    return(invisible(TRUE))
  }
  testthat::skip("if on local computer")
}
