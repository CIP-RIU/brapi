#' chart
#'
#' @param x an object to be charted
#' @param ... additional parameters
#' @author Reinhard Simon
#' @export
chart <- function (x, ...) {
  UseMethod("chart", x)
}
