#' ba_login
#'
#' Login into a brapi compatible database.
#'
#' Caches a session token and informs of success or failure.
#'
#' @param con A required object of class 'brapi_con'.
#'
#' @return The object of class 'brapi_con' with the authentication token filled.
#'
#' @author Reinhard Simon, Maikel Verouden
#' @example inst/examples/ex-ba_login.R
#' @import httr
#' @family brapiutils
#' @export
ba_login <- function(con) {
  stopifnot(is.ba_con(con))
  brapi <- con
  # Check for internet connection
  ba_can_internet()
  # Set authentication URL
  callpath <- "token"
  omc <- brapi$multicrop
  brapi$multicrop <- FALSE
  callurl <- paste0(get_brapi(brapi), callpath)
  brapi$multicrop <- omc
  dat <- list(grant_type = "password",
              username = brapi$user,
              password = brapi$password,
              client_id = "")
  # Make POST call for submitting form data
  resp <- httr::POST(url = callurl,
                     body = dat,
                     encode = ifelse(brapi$bms == TRUE, "json", "form"))
  # Check response status
  if (resp$status_code == 401) {
    # Status Unauthorized
    httr::stop_for_status(resp, task = "authenticate. Check your username and password!")
  } else {
    # Status other than unauthorized
    if (resp$status_code != 200) {
      # Status other than Unauthorized and OK
      httr::stop_for_status(resp)
    } else {
      # Status OK Extract token out of resp(onse) from POST call
      token <- httr::content(resp)$access_token
      brapi$token <- token
      brapi$expires_in <- httr::content(resp)$expires_in
      message("Authenticated!")
    }
  }
  ## Return brapi object with
  return(brapi)
}
