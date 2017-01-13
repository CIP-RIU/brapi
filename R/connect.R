
#' connect
#'
#' Sets a global list variable 'brapi' that contains all parameters to connect to
#' a BrAPI compliant online database.
#'
#' The default values are chosen to match a local mock test server. The mock server
#' must be started in a separate R session using 'brapi::mock_server()'.
#'
#' If the brapi_db parameter is used it will override the other parameters; except user, password and session.
#'
#' @param brapiDb brapiDb R object for brapi databases. Created by as.brapi_db
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

#' @example inst/examples/ex_connect.R
#' @return connection object
#' @family access
#' @export
connect <- function(brapiDb = NULL, secure = FALSE, protocol = "http://", db = "127.0.0.1", port = 2021, 
    apipath = NULL, multicrop = FALSE, crop = "sweetpotato", user = "user", password = "password", token = "", 
    granttype = "password", clientid = "rbrapi", bms = FALSE) {
    brapi <- NULL
    
    if (!is.null(brapiDb)) {
        if ("list" %in% class(brapiDb)) {
            brapi <- brapiDb
            class(brapi) <- c("list", "brapi")
        }
    } else {
        
        if (!brapi::can_internet()) {
            stop("Can not connect to internet!")
        }
        # Check function arguments
        if (!is.logical(secure)) {
            stop("The secure argument in brapi_con() can only be a logical (TRUE or FALSE) value.")
        }
        if (!is.character(db)) {
            stop("The db argument in brapi_con() can only be a character string.")
        }
        if (!is.numeric(port)) {
            stop("The port argument in brapi_con() can only be a numeric value.")
        }
        if (!is.logical(bms)) {
            stop("The bms argument argument in brapi_con() can only be a logical value (TRUE or FALSE).")
        }
        if (!xor(is.null(apipath), is.character(apipath))) {
            stop("The apipath argument in brapi_con() can only be NULL or a character string.")
        }
        if (!is.character(crop)) {
            stop("The crop argument in brapi_con() can only be a character string.")
        }
        if (!is.logical(multicrop)) {
            stop("The multicrop argument in brapi_con() can only be a logical value (TRUE or FALSE).")
        }
        if (!is.character(user)) {
            stop("The user argument in brapi_con() can only be a character string.")
        }
        if (!is.character(password)) {
            stop("The password argument in brapi_con() can only be a character string.")
        }
        if (!is.character(token)) {
            stop("The token argument in brapi_con() can only be a character string.")
        }
        # bms == TRUE, then always multicrop == TRUE
        if (bms == TRUE) {
            multicrop <- TRUE
        }
        
        brapi <- list(brapi_db = brapi_db, secure = secure, protocol = protocol, db = db, port = port, apipath = apipath, 
            multicrop = multicrop, crop = crop, user = user, password = password, token = token, granttype = granttype, 
            clientid = clientid, bms = bms, crops = "", calls = "")
        class(brapi) <- c(class(brapi), "brapi_con", "brapi")
    }
    # message_brapi() show_info(FALSE) brapi$crops <- crops(brapi, rclass = 'vector') brapi$crops %>%
    # paste(collapse = ', ') %>% message_brapi() brapi$calls <- calls(brapi, rclass = 'data.frame')[,
    # 'call'] brapi$calls %>% paste(collapse = ', ') %>% message_brapi()
    brapi
}

