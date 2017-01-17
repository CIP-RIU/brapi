#' chart
#'
#' A generic method to chart brapi objects
#'
#' @param x an object to be charted
#' @param ... additional parameters
#' @author Reinhard Simon
#' @family brapiutils
#' @export
chart <- function (x, ...) {
  UseMethod("chart", x)
}
