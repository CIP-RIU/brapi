#' chart
#'
#' A generic method to chart brapi objects
#'
#' @param x an object to be charted
#' @param ... additional parameters
#' @author Reinhard Simon
#' @example inst/examples/ex-chart.R
#' @family brapiutils
#' @export
chart <- function (x, ...) {
  return(UseMethod("chart", x))
}


#' describe
#'
#' A generic method to sum up brapi objects
#'
#' @param x an object to be described
#' @param ... additional parameters
#' @author Reinhard Simon
#' @example inst/examples/ex-describe.R
#' @family brapiutils
#' @export
describe <- function (x, ...) {
  return(UseMethod("describe", x))
}
