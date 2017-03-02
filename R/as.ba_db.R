#' as.ba_db
#'
#' @param secure logical; default: false
#' @param protocol character
#' @param db character
#' @param port integer; default: 80
#' @param apipath character; default: ''
#' @param multicrop logical; default: false
#' @param crop character
#' @param user character; default: ''
#' @param password character; default: ''
#' @param token character; default: ''
#' @param granttype character; default: 'password'
#' @param clientid character; default: 'rbrapi'
#' @param bms logical; default: false
#'
#' @return ba_db class
#' @author Reinhard Simon, Maikel Verouden
#' @example inst/examples/ex-as_ba_db.R
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
                        bms = FALSE) {
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
           bms = bms)

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
              crops = "",
              calls = "")
    class(out) <- c(class(out),
                    "ba_db",
                    "ba",
                    "ba_con")
    return(out)
}
