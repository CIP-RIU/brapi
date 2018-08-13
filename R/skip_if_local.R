
#' skip_if_local
#'
#' A helper function to minimize time consuming testing against databases locally.
#'
#' Only used within formal tests of the package.
#'
#' @return boolean
#' @export
skip_if_local <- function() {
  if (as.integer(Sys.getenv("NUMBER_OF_PROCESSORS") < 13 )) {
    return(invisible(TRUE))
  }
  testthat::skip("if on local computer")
}
