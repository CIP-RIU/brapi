
#' ba_show_expiration
#'
#' @param con
#'
#' @export
#'
#' @examples
#'
#' library(brapi)
#' if (interactive()) {
#'   con <- ba_db()$testserver
#'   ba_show_expiration(con)
#' }
ba_show_expiration <- function(con) {


  if ("expires_in" %in% names(con)) {
    tokenExpires <- as.POSIXct(con$expires_in/1000, origin = "1970-01-01")

    ba_message(msg = paste0("Database connection expires: ",
                            tokenExpires))
  } else {
    ba_message(msg = paste0("Database connection expiration time unknown."))
  }

}
