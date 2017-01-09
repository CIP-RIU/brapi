
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
#' @param brapi_db brapi_db R object for brapi databases. Created by as.brapi_db
#' param brapiDb brapi_db R object for brapi databases. Created by as.brapi_db
# param secure logical TRUE/FALSE
#' @param protocol string; default: http:// (else: https://)
#' @param db string; default '127.0.0.1' (localhost)
#' @param port integer; default: 80
# param apipath character; default NULL
# param multicrop logical; default FALSE
#' @param crop string; default: ''

#' @param user string; default: user
#' @param password string; default: password
# param token
#' @param session string; default: '' (empty)

#' @param multi logical; default: FALSE
# param granttype
# param clientid
# param bms TRUE/FALSE

#' @example inst/examples/ex_connect.R
#' @return logical
#' @family access
#' @export
connect <- function(brapi_db = NULL, crop = "sweetpotato", db = "127.0.0.1", port = 2021,
                    protocol = "http://", multi = FALSE,
                    user = "user", password = "password", session = ""){
  brapi <<- list(
    crop = crop,
    db = db,
    port = port,
    user = user,
    password = password,
    sesssion = session,
    protocol = protocol,
    multi = multi,
    crops = "",
    calls = ""
  )
  if(!is.null(brapi_db) && class(brapi_db) == "brapi_db"){
    brapi$crop <<- brapi_db$crop
    brapi$protocol <<- brapi_db$protocol
    brapi$db <<- brapi_db$db
    brapi$port <<- brapi_db$port
    brapi$multi <<- brapi_db$multi
  }
  message_brapi()
  #show_info(FALSE)
  brapi$crops <<- crops(rclass = "vector")
  brapi$crops %>% paste(collapse = ", ") %>% message_brapi()
  brapi$calls <<- calls(rclass = "data.frame")[, "call"]
  brapi$calls %>% paste(collapse = ", ") %>% message_brapi()
  #show_info(TRUE)
  "ok"
}

