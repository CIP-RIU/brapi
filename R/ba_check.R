#' ba_check
#'
#' Checks if a BrAPI server can be reached given the connection details.
#'
#' Raises errors.
#' @param con brapi_connection object
#' @param verbose logical; default TRUE
#' @param brapi_calls character vector; default: any. Use to check if one or more calls are implemented by the server according to the calls url.
#' @family brapiutils
#'
#' @return logical
#' @author Reinhard Simon
#' @example inst/examples/ex-ba_check.R
#' @export
ba_check <- function(con = NULL, verbose = TRUE, brapi_calls = "any") {
  stopifnot(is.ba_con(con))
  stopifnot(is.logical(verbose))
  stopifnot(is.character(brapi_calls))
  brapi <- con
  if (is.null(brapi)) {
    stop("BrAPI connection object is NULL. Use brapi::connect()")
  }
  url <- brapi$db
  # check for localhost
  if (stringr::str_detect(string = brapi$db, pattern = "127")) {
    url <- paste0(brapi$db, ":", brapi$port, "/brapi/v1/")
    status <- 600
    status <- try({
      httr::GET(url = url)$status_code
    })
    if (status == 600) {
      stop("Cannot connect to mock server. Use other connection details or start the mock server.")
    }
  } else {
    ba_can_internet()
    ba_can_internet(url)
  }
  if (verbose) {
    message("BrAPI connection ok.")
    message(paste(brapi, collapse = "\n"))
  }
  return(TRUE)
}
