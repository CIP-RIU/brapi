#' ba_logout
#'
#' Logout from a brapi compatible database.
#'
#' @param con list, brapi connection object
#'
#' @return The list object of class 'brapi_con' with the authentication token
#'         removed.
#'
#' @note Tested against: sweetpotatobase
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Authentication/Authentication.md}{github}
#' @family brapiutils
#' @example inst/examples/ex-ba_logout.R
#' @import httr
#' @export
ba_logout <- function(con) {
  stopifnot(is.ba_con(con))
  ba_can_internet()
  # save old multicrop value
  omc <- con$multicrop
  con$multicrop <- FALSE
  brp <- get_brapi(con = con)
  callurl <- paste0(brp, "token")
  # set multicrop to its old multicrop value
  con$multicrop <- omc
  dat <- list(access_token = con$token)
  ba_message(jsonlite::toJSON(x = dat, pretty = TRUE))
  # obtain response from httr::delete call
  resp <- httr::DELETE(url = callurl,
                       body = dat,
                       encode = ifelse(con$bms == TRUE, "json", "form"))
  # Status other than unauthorized
  if (resp$status_code != 200) {
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
