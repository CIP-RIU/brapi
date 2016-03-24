
#' germplasm MCPD data
#'
#' @param id integer
#' @import httr
#' @author Reinhard Simon
#' @return list
#' @export
germplasm_mcpd <- function(id = NULL){
  check_id(id)
  #TODO double check with Nick
  rsp = brapi_GET(paste0("germplasm/",id, "/mcpd"))
  httr::content(rsp)$result
}
