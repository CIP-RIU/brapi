#' Tas.brapi_db
#'
#' @param crop character
#' @param protocol character
#' @param db character
#' @param port integer
#' @param multi logical
#'
#' @return brapi_db class
#' @export
as.brapi_db <- function(crop = "any", protocol = "http://", db = "127.0.0.1", port = 80, multi=FALSE){
  out <- list(
    crop = crop,
    protocol = protocol,
    db = db,
    port = port,
    multi = multi
  )
  class(out) = "brapi_db"
  out
}
