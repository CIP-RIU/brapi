#' as.ba_db
#'
#' @param secure logical; default: false
#' @param protocol character. Protocol used for accessing API, typically 'http://' or 'https://'
#' @param db character. domain name
#' @param port integer; default: 80
#' @param apipath character; default: '' path appended to db where the api is hosted 
#' @param multicrop logical; default: false. Does this database host more than one crop?
#' @param crop character. Name of crop(s) hosted
#' @param user character; default: ''
#' @param password character; default: ''
#' @param token character; default: ''
#' @param granttype character; default: 'password'
#' @param clientid character; default: 'rbrapi'
#' @param bms logical; default: false. Does this endpoint follow the BMS implementation of BrAPI?
#' @param version character; default: 'v1'. Which version(s) of BrAPI are supported?
#'
#' @return ba_db class
#' @author Reinhard Simon, Maikel Verouden
#' @example inst/examples/ex-as_ba_db.R
#' @family brapiutils
#' @export
as.ba_db <- function(secure = FALSE,
                     protocol = "http://",
                     db = "127.0.0.1",
                     port = 80,
                     apipath = NULL,
                     multicrop = FALSE,
                     crop = "",
                     user = "",
                     password = "",
                     token = "",
                     granttype = "password",
                     clientid = "rbrapi",
                     bms = FALSE,
                     version = 'v1')  {
  check_ba(secure = secure,
           protocol = protocol,
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
           bms = bms,
           version = version)
  out <- list(secure = secure,
              protocol = protocol,
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
              bms = bms,
              version = version,
              crops = "",
              calls = "")
  class(out) <- c(class(out), "ba_db", "ba", "ba_con")
  return(out)
}
