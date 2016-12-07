
#' check
#'
#' Checks if a BrAPI server can be reached given the connection details.
#'
#' Raises errors.
#'
#' @param verbose logical; default TRUE
#'
#' @return logical
#' @export
check <- function(verbose = TRUE){
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
    url <- get_brapi()
    if(!can_internet(url))  stop(paste0("Cannot connect to BrAPI server: ", url, "\nCheck the details."))
  }

  if(verbose){
    message("BrAPI connection ok.")
    message(paste(brapi, collapse = "\n"))
  }
  TRUE
}
