#' can_internet
#'
#' Check for internet connection.
#'
#' @param url a url to check (default \href{https://www.google.org}{www.google.org})
#' @return logical TRUE when internet access is available or FALSE when internet access is not available
#' @references \href{http://stackoverflow.com/questions/5076593/how-to-determine-if-you-have-an-internet-connection-in-r}{Stack Overflow} and  \code{\link[curl]{has_internet}}
#' @importFrom curl nslookup
#' @export
can_internet <- function(url = "www.google.org") {
    return(!is.null(curl::nslookup(url, error = FALSE)))
}
