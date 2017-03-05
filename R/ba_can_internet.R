#' ba_can_internet
#'
#' Check for internet connection.
#'
#' @param url a url to check (default \href{https://www.google.org}{www.google.org})
#' @return NULL when internet access is available or ERROR when internet access is not available
#' @example inst/examples/ex-can_internet.R
#' @references \href{http://stackoverflow.com/questions/5076593/how-to-determine-if-you-have-an-internet-connection-in-r}{Stack Overflow} and  \code{\link[curl]{has_internet}}
#' @importFrom curl nslookup
#' @family brapiutils
#' @export
ba_can_internet <- function(url = "www.google.org") {
  stopifnot(is.character(url))
  return(invisible(curl::nslookup(url)))
}
