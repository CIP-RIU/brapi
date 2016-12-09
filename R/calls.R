#' calls
#'
#' lists calls available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param datatypes string, list of data types
#'
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/call-search}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family core
#' @family access
#' @export
calls <- function(datatypes = "all", rclass = "tibble") {
  brapi::check(FALSE)
  brp <- get_brapi()
  if(datatypes == "all"){
    calls_list = paste0(brp, "calls")
  } else {
    calls_list = paste0(brp, "calls/?datatypes=", datatypes)
  }

  tryCatch({
    res <- brapiGET(calls_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    dat2tbl(res, rclass)
  }, error = function(e){
    NULL
  })
}
