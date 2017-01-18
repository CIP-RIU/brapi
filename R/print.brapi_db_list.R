#' print.brapi_db_list
#'
#' print method for an object of class brapi_db_list
#'
#' @param x a brapi_db_list object
#' @param ... other print parameters
#' @author Reinhard Simon, Maikel Verouden
#' @family brapiutils
#' @export
print.brapi_db_list <- function(x, ...) {
    names(x) %>% sort %>% paste(collapse = "\n") %>% cat
}
