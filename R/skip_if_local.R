skip_if_local <- function() {
  if (!identical(Sys.getenv("NOT_CRAN"), "true")) {
    return(invisible(TRUE))
  }
  skip("if on local computer")
}
