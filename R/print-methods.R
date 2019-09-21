#' print.ba_con
#'
#' print method for an object of class brapi_con, which will only display the crop,  database address:port and user
#'
#' @param x a brapi_con object
#' @param ... other print parameters
#' @author Reinhard Simon, Maikel Verouden
#' @family brapiutils
#' @export
print.ba_con <- function(x, ...) {
  # Print in console
  txt <- paste0("Crop = ", x$crop, "\n\n")
  txt <- paste0(txt, "Address:Port = ", x$db, ":", x$port, "\n")
  cat(paste0(txt, "User = ", x$user, "\n"))
  return(invisible())
}


#' print.ba_db_list
#'
#' print method for an object of class ba_db_list
#'
#' @param x a ba_db_list object
#' @param ... other print parameters
#' @author Reinhard Simon, Maikel Verouden
#' @family brapiutils
#' @export
print.ba_db_list <- function(x, ...) {
  names(x) %>% sort %>% paste(collapse = "\n") %>% cat
  return(invisible())
}
