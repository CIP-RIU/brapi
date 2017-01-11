#' Authenticate against a brapi compatible database.
#'
#' Caches a session token and informs of success or failure.
#'
#' @param brapi A required object of class 'brapi_con'.
#'
#' @return The object of class 'brapi_con' with the authentication token filled.
#'
#' @author Reinhard Simon, Maikel Verouden
#' @import httr
#' @family brapi_con
#' @export
authenticate <- function(brapi) {
  # Check for internet connection
  if (!brapi::can_internet()) {
    stop("Authentication failed, because there is no connection to the internet")
  }
  # Check function arguments
  if (is.null(brapi) ) {
    stop("The brapi argument is empty or not of class brapi_con, please use brapi_con() first to create a valid brapi argument of class brapi_con.")
  }
  # Set authentication URL
  if (brapi$bms == TRUE) {
    # For BMS
    callurl <- paste0(get_brapi(brapi),
                      # brapi$db, ":", brapi$port,
                      # paste0(brapi$apipath,
                             "authenticate")
  } else {
    # For other database systems
    callurl <- paste0(get_brapi(brapi),
                      "token")
  }
  # Create Body data for POST call
  dat <- list(grant_type = "password",
              username = brapi$user,
              password = brapi$password)
  # Make POST call for submitting form data
  resp <- httr::POST(url = callurl,
                     body = dat,
                     httr::add_headers("Content-Type" = "multipart/form-data"))
  # Extract token out of resp(onse) from POST call
  if (brapi$bms == TRUE) {
    # For BMS
    token <- httr::content(resp)$token
  } else {
    # For other database systems
    token <- httr::content(resp)$access_token
  }
  # Check token assignment
  if (length(token) == 0 | token == "") {
    # No token assigned
    stop("Authentication failed. Check your username and password!")
  } else {
    # Proper token assignment
    brapi$token <- token
    message("Authenticated!")
  }
  ## Return brapi object with
  return(brapi)
}
