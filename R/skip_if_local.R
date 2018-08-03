skip_if_local <- function() {
  if (as.integer(Sys.getenv("NUMBER_OF_PROCESSORS") < 13 )) {
    return(invisible(TRUE))
  }
  skip("if on local computer")
}
