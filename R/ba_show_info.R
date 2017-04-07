#' ba_show_info
#'
#' Show informative messages or not
#'
#' @param show logical
#' @family utility
#' @export
ba_show_info <- function(show = TRUE) {
    stopifnot(is.logical(show))
    options(brapi_info = show)
    return(invisible())
}
