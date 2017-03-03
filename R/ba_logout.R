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
#' @import httr
#' @family brapiutils
#' @export
ba_logout <- function(con) {
  stopifnot(is.ba_con(con))
  brapi <- con
  # Check for internet connection
  if (!ba_can_internet()) {
    stop("Logout failed,
       because there is no connection to the internet")
  }
  # Set authentication URL
  callpath <- "token"
  omc <- brapi$multicrop
  brapi$multicrop <- FALSE
  callurl <- paste0(get_brapi(brapi), callpath)
  brapi$multicrop <- omc
  dat <- list(access_token = brapi$token)
  # Make POST call for submitting form data
  resp <- httr::DELETE(url = callurl,
                     body = dat,
                     encode = ifelse(brapi$bms == TRUE, "json", "form"))
    # Status other than unauthorized
    if (resp$status_code != 201) {
      # Status other than Unauthorized and OK
      httr::stop_for_status(resp)
    } else {

      brapi$token <- ""
      message("Successfully logged out!")
    }

  ## Return brapi object with
  return(brapi)
}
