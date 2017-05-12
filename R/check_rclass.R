check_rclass <- function(rclass = NULL) {
  msg <- "rclass must be a character object with a value of either: json, list, tibble, data.frame, vector"
  if (is.null(rclass)) stop(msg)
  if (!(rclass %in% c("json", "list", "tibble", "data.frame", "vector"))) {
    stop(msg)
  }
  return(invisible(TRUE))
}
