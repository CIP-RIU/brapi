#' describe
#'
#' A generic method to sum up brapi objects
#'
#' @param x an object to be described
#' @param ... additional parameters
#' @author Reinhard Simon
#' @family brapiutils
#' @export
describe <- function (x, ...) {
  UseMethod("describe", x)
}
