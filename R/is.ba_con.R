#' is.ba_con
#'
#' check whether an object is of class brapi_con
#'
#' @param obj object to be tested
#'
#' @return boolean (TRUE of FALSE)
#' @author Reinahard Simon, Maikel Verouden
#' @family brapiutils
#' @export
is.ba_con <- function(obj) {
    res <- "ba_con" %in% class(obj)
    return(res)
}
