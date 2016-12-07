#' show_info
#'
#' Show informative messages or not
#'
#' @param show logical
#' @export
show_info <- function(show = TRUE){
  options(brapi_info = show)
}
