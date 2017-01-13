
#' check
#'
#' Checks if a BrAPI server can be reached given the connection details.
#'
#' Raises errors.
#' @param con brapi_connectin object
#' @param verbose logical; default TRUE
#' @param brapi_calls character vector; default: any. Use to check if one or more calls are implemented by the server according to the calls url.
#' @family brapi_util
#' @return logical
#' @export
check <- function(con = NULL, verbose = TRUE, brapi_calls = "any") {
    stopifnot(is.brapi(con))
    brapi <- con
    # if(!('brapi' %in% ls(envir = globalenv()))) stop('BrAPI connection details not available. Use
    # brapi::connect()')
    if (is.null(brapi)) 
        stop("BrAPI connection object is NULL. Use brapi::connect()")
    
    url <- brapi$db
    
    if (stringr::str_detect(brapi$db, "127")) {
        url <- paste0(brapi$db, ":", brapi$port, "/brapi/v1/")
        status <- 600
        status <- try({
            httr::GET(url)$status_code
        })
        if (status == 600) 
            stop("Cannot connect to mock server. Use other connection details or start the mock server.")
    } else {
        if (!can_internet()) 
            stop("No internet connection. Check your LAN or WIFI.")
        if (!can_internet(url)) 
            stop(paste0("Cannot connect to BrAPI server: ", url, "\nCheck the details."))
    }
    
    # if(!('any' %in% brapi_calls)){ call_check = !brapi_calls %in% brapi$calls if(any(call_check)){
    # stop(paste0( paste(brapi_calls[call_check], collapse= ', '), ' not implemented by server: ', brapi$db
    # ) ) } }
    
    if (verbose) {
        message("BrAPI connection ok.")
        message(paste(brapi, collapse = "\n"))
    }
    TRUE
}
