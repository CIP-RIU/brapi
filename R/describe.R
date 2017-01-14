#' describe
#'
#' @param x an object to be described
#' @param ... additional parameters
#' @author Reinhard Simon
#' @export
describe <- function (x, ...) {
  UseMethod("describe", x)
}
