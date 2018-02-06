#' ba_logout
#'
#' Logout from a brapi compatible database.
#'
#'
#' @param con A required object of class 'brapi_con'.
#'
#' @return The object of class 'brapi_con' with the authentication token removed.
#'
#' @author Reinhard Simon
#' @example inst/examples/ex-ba_logout.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Authentication/Authentication.md}{github}
#' @import httr
#' @family brapiutils
#' @export
ba_logout <- function(con) {
  stopifnot(is.ba_con(con))
  # Check for internet connection
  ba_can_internet()
  # Set authentication URL
  callpath <- "token"
  omc <- con$multicrop
  con$multicrop <- FALSE
  callurl <- paste0(get_brapi(con = con), callpath)
  con$multicrop <- omc
  dat <- list(access_token = con$token)
  ba_message(jsonlite::toJSON(x = dat, pretty = TRUE))
  # obtain response from httr::delete call
  resp <- httr::DELETE(url = callurl,
                       body = dat,
                       encode = ifelse(con$bms == TRUE, "json", "form"))
  # Status other than unauthorized
  if (resp$status_code != 201) {
    # Status other than Unauthorized and OK
    con$token <- ""
    httr::stop_for_status(x = resp)
  } else {
    xout <- httr::content(x = resp)
    ba_message(msg = jsonlite::toJSON(xout, pretty = TRUE))
    con$token <- ""
    message("Successfully logged out!")
  }
  ## Return con object with
  return(con)
}
