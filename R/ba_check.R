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
  if (is.null(con)) {
    stop("BrAPI connection object is NULL. Use brapi::ba_connect()")
  }
  url <- con$db
  # if(brapi_calls != "calls") {
  #   if(!(brapi_calls %in% ba_calls(con)$call)) {
  #     message("Call not implemented according to calls result..")
  #   }
  # }

  # check for localhost
  if (stringr::str_detect(string = con$db, pattern = "127")) {
    url <- paste0(con$db, ":", con$port, "/brapi/v1/")
    status <- 600
    status <- try({
      httr::GET(url = url)$status_code
    })
    if (status == 404) {
      stop("Call not implemented.")
    }

    if (status == 600) {
      stop("Cannot connect to server. Use other connection details.")
    }
  } else {
    ba_can_internet()
    ba_can_internet(url)
  }

  if (verbose) {
    ba_message("BrAPI connection ok.")
    ba_message(paste(con, collapse = "\n"))
  }
  return(TRUE)
}
