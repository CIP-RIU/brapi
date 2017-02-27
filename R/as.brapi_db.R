#' as.brapi_db
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
#' @return brapi_db class
#' @export
as.brapi_db <- function(secure = FALSE,
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
                    "brapi_db",
                    "brapi",
                    "brapi_con")
    return(out)
}
