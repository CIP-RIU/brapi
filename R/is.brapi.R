#' is.brapi
#'
#' check if the connection object is correct
#'
#' @param con brapi connection object
#' @family brapiutils
#' @return logical
#' @export
is.brapi <- function(con) {
  any(lapply(con, stringr::str_detect, "brapi") %>% unlist)
}
