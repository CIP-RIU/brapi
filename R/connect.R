
#' connect
#'
#' Sets a global list variable 'brapi' that contains all parameters to connect to
#' a BrAPI compliant online database.
#'
#' The default values are chosen to match a local mock test server. The mock server
#' must be started in a separate R session using 'brapi::mock_server()'.
#'
#'
#' @param crop string; default: sweetpotato
#' @param db string; default '127.0.0.1' (localhost)
#' @param port integer; default: 2021
#' @param protocol string; default: http:// (else: https://)
#' @param multi logical; default: FALSE
#' @param user string; default: user
#' @param password string; default: password
#' @param session string; default: '' (empty)
#'
#' @return logical
#' @family access
#' @export
connect <- function(crop = "sweetpotato", db = "127.0.0.1", port = 2021,
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
  message_brapi()
  #show_info(FALSE)
  brapi$crops <<- crops(rclass = "vector")
  brapi$crops %>% paste(collapse = ", ") %>% message_brapi()
  brapi$calls <<- calls(rclass = "data.frame")[, "call"]
  brapi$calls %>% paste(collapse = ", ") %>% message_brapi()
  #show_info(TRUE)
  "ok"
}

