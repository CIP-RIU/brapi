
#' check
#'
#' Checks if a BrAPI server can be reached given the connection details.
#'
#' Raises errors.
#'
#' @param verbose logical; default TRUE
#' @param brapi_calls character vector; default: any. Use to check if one or more calls are implemented by the server according to the calls url.
#'
#' @return logical
#' @export
check <- function(verbose = TRUE, brapi_calls = "any"){
  if(!("brapi" %in% ls(envir = globalenv()))) stop("BrAPI connection details not available. Use brapi::connect()")
  if(is.null(brapi))     stop("BrAPI connection object is NULL. Use brapi::connect()")

  if(!can_internet())      stop("No internet connection. Check your LAN or WIFI.")


  if(stringr::str_detect(brapi$db, "127")){
    url <- paste0(brapi$db, ":", brapi$port, "/brapi/v1/")
    status <- tryCatch({
      httr::GET(url)$status_code
    }, error = function(e){
      500
    })
    if(status == 500) stop("Cannot connect to mock server. Use other connection details or start the mock server.")
  } else {
    url <- brapi$db
    if(!can_internet(url))  stop(paste0("Cannot connect to BrAPI server: ", url, "\nCheck the details."))

  }

  if(brapi_calls != "any"){
    call_check = !brapi_calls %in% brapi$calls
    if(any(call_check)){
      # message(brapi_calls)
      # message(brapi_calls[call_check])
      stop(paste0(
        paste(brapi_calls[call_check], collapse= ", "),
        " not implemented by server: ", brapi$db )
        )
    }

  }

  if(verbose){
    message("BrAPI connection ok.")
    message(paste(brapi, collapse = "\n"))
  }
  TRUE
}
