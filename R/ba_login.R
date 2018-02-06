#' ba_login
#'
#' Login into a brapi compatible database.
#'
#' Caches a session token and informs of success or failure.
#'
#' @param con A required object of class 'brapi_con'.
#'
#' @return The object of class 'brapi_con' with the authentication token filled.
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Authentication/Authentication.md}{github}
#' @author Reinhard Simon, Maikel Verouden
#' @example inst/examples/ex-ba_login.R
#' @import httr
#' @family brapiutils
#' @export
ba_login <- function(con) {
  stopifnot(is.ba_con(con))
  # Check for internet connection
  ba_can_internet()
  # Set authentication URL
  callpath <- "token"
  # save old multicrop value
  omc <- con$multicrop
  con$multicrop <- FALSE
  # generate brapi call specific url
  callurl <- paste0(get_brapi(con = con), callpath)
  # set multicrop to its old multicrop value
  con$multicrop <- omc
  dat <- list(username = con$user,
              password = con$password,
              grant_type = "password",
              client_id = "")
  ba_message(msg = jsonlite::toJSON(x = dat, pretty = TRUE))
  # Make POST call for submitting form data
  resp <- httr::POST(url = callurl,
                     body = dat,
                     encode = ifelse(con$bms == TRUE, "json", "form"))
  # Check response status
  if (resp$status_code == 401) {
    # Status Unauthorized
    httr::stop_for_status(x = resp,
                          task = "authenticate. Check your username and password!")
  } else {
    # Status other than unauthorized
    if (resp$status_code != 200) {
      # Status other than Unauthorized and OK
      httr::stop_for_status(x = resp)
    } else {
      # Status OK Extract token out of resp(onse) from POST call
      xout <- httr::content(x = resp)
      token <- xout$access_token
      con$token <- token
      con$expires_in <- httr::content(x = resp)$expires_in
      ba_message(jsonlite::toJSON(x = xout, pretty = TRUE))
      message("Authenticated!")
    }
  }
  return(con)
}
