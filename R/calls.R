#' calls
#'
#' lists calls available on a brapi server
#'
#' @param datatypes string, list of data types
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/call-search}
#' @return a data.frame
#' @export
calls <- function(datatypes = "all") {
  brapi::check(FALSE)
  if(datatypes == "all"){
    calls_list = paste0(get_brapi(), "calls")
  } else {
    calls_list = paste0(get_brapi(), "calls/?datatypes=", datatypes)
  }


  calls <- tryCatch({
    res <- httr::GET(calls_list)
    jsonlite::fromJSON(
      httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
                    ), simplifyVector = FALSE
    )
  }, error = function(e){
    NULL
  })

  calls
}
