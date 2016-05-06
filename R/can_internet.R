
#' can_internet
#'
#' Check for internet connection.
#'
#' @references stackoverflow
#' @return logical TRUE or FALSE
#' @export
can_internet <- function(){
  !is.null(curl::nslookup("www.google.org", error = FALSE))
}
