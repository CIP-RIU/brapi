
#' germplasm details
#'
#' @param id integer number
#' @author Reinhard Simon
#' @import httr
#' @return list of lists
#' @export
germplasm_details <- function(id = NULL){
  .Deprecated("germplasm")
  rsp = brapi_GET(paste0("germplasm/",id))
  httr::content(rsp)$result
}
