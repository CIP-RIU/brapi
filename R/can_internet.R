
#' can_internet
#'
#' Check for internet connection.
#'
#' @param url a url to check; default is Google
#' @references stackoverflow
#' @return logical TRUE or FALSE
#' @export
can_internet <- function(url = "www.google.org"){
  !is.null(curl::nslookup(url, error = FALSE))
}
