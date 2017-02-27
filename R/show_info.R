#' show_info
#'
#' Show informative messages or not
#'
#' @param show logical
#' @family utility
#' @export
show_info <- function(show = TRUE) {
    options(brapi_info = show)
    return(message(paste0("Show info: ", show)))
}
