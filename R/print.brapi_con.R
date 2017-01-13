#' print.brapi_con
#'
#' print method for an object of class brapi_con, which will only display the crop,  database address:port and user
#'
#' @param x a brapi_con object
#' @param ... other print parameters
#' @author Reinhard Simon, Maikel Verouden
#' @family brapi_con
#' @export
print.brapi_con <- function(x, ...) {
    # Print in console
    cat(paste0("Crop = ", x$crop, "\n\n"))
    cat(paste0("Addres:Port = ", x$db, ":", x$port, "\n"))
    cat(paste0("User = ", x$user, "\n"))
}
