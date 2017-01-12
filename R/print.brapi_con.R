#' print.brapi_con
#'
#' print method for an object of class brapi_con, which will only display the crop,  database address:port and user
#'
#' @param brapi a brapi_con object
#' @param ... other print parameters
#' @author Reinhard Simon, Maikel Verouden
#' @family brapi_con
#' @export
print.brapi_con <- function(brapi, ...) {
  # Print in console
  cat(paste0("Crop = ", brapi$crop, "\n\n"))
  cat(paste0("Addres:Port = ", brapi$db, ":", brapi$port, "\n"))
  cat(paste0("User = ", brapi$user, "\n"))
}
