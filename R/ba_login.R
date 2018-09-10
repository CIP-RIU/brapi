#' ba_login
#'
#' Login into a brapi compatible database.
#'
#' @param con list, brapi connection object
#'
#' @details Caches a session token and informs of success or failure.
#'
#' @return The list object of class 'brapi_con' with the authentication token filled.
#'
#' @note Tested against: BMS, sweetpotatobase
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Authentication/Authentication.md}{github}
#' @family brapiutils
#' @example inst/examples/ex-ba_login.R
#' @import httr
#' @export
ba_login <- function(con) {
  stopifnot(is.ba_con(con))
  ba_can_internet()
  # save old multicrop value
  omc <- con$multicrop
  con$multicrop <- FALSE
  brp <- get_brapi(con = con)
  callurl <- paste0(brp, "token")
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
