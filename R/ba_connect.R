#' ba_connect
#'
#' Sets a global list variable 'brapi' that contains all parameters to connect to
#' a BrAPI compliant online database.
#'
#' The default values are chosen to match a local mock test server. The mock server
#' must be started in a separate R session using 'brapi::mock_server()'.
#'
#' If the brapi_db parameter is used it will override the other parameters; except user, password and session.
#'
#' @param brapiDb brapiDb R object for brapi databases created by as.ba_db [default: NULL]
#' @param secure logical TRUE/FALSE
#' @param protocol string; default: http:// (else: https://)
#' @param db string; default '127.0.0.1' (localhost)
#' @param port integer; default: 80
#' @param apipath character; default NULL
#' @param multicrop logical; default FALSE
#' @param crop string; default: ''
#' @param user string; default: user
#' @param password string; default: password
#' @param token string; default: '' (empty)
#' @param granttype string
#' @param clientid string: default: rbrapi
#' @param bms logical; default: FALSE

#' @author Reinhard Simon, Maikel Verouden
#' @example inst/examples/ex_connect.R
#' @return connection object
#' @family brapiutils
#' @export
ba_connect <- function(brapiDb = NULL, secure = FALSE, protocol = "http://", db = "127.0.0.1",
                       port = 2021, apipath = NULL, multicrop = FALSE, crop = "sweetpotato",
    user = "user", password = "password", token = "", granttype = "password", clientid = "rbrapi", bms = FALSE) {
    brapi <- NULL
    if (!is.null(brapiDb)) {
        # brapiDb agrument was not NULL but passed
        if (all(class(brapiDb) == c("list", "ba_db", "ba", "ba_con"))) {
            brapi <- brapiDb

        }
    } else {
        # check for net connectivity
        ba_can_internet()
        check_ba(secure = secure, protocol = protocol, db = db, port = port, apipath = apipath,
                 multicrop = multicrop, crop = crop, user = user,
            password = password, token = token, granttype = granttype, clientid = clientid, bms = bms)

        # bms == TRUE, then always multicrop == TRUE
        if (bms == TRUE) {
            multicrop <- TRUE
        }
        # create brapi list object from passed arguments
        brapi <- list(secure = secure, protocol = protocol, db = db, port = port, apipath = apipath,
                      multicrop = multicrop, crop = crop, user = user,
            password = password, token = token, granttype = granttype, clientid = clientid, bms = bms,
            crops = "", calls = "")
        class(brapi) <- c(class(brapi), "ba", "ba_con")
    }
    return(brapi)
}
