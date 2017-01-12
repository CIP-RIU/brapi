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
as.brapi_db <- function(
  secure = FALSE,
  protocol = "http://",
  db = "127.0.0.1",
  port = 2021,
  apipath = NULL,
  multicrop = FALSE,
  crop = "",
  user = "",
  password = "",
  token = "",
  granttype = "password",
  clientid = "rbrapi",
  bms = FALSE
  ){

  out <- list(
    secure = secure,
    secure = secure,
    db = db,
    port = port,
    apipath = apipath,
    multicrop = multicrop,
    crop = crop,
    user = user,
    password = password,
    token = token,
    granttype = granttype,
    clientid = clientid,
    bms = bms
  )
  class(out) <- c("list", "brapi_db", "brapi")
  out
}
