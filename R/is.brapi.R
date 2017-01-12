#' is.brapi
#'
#' check if the connection object is correct
#'
#' @param con brapi connection object
#' @family brapi_util
#' @return logical
#' @export
is.brapi <- function(con){
  "brapi" %in% class(con)
}
