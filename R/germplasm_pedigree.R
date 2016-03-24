
#' germplasm_pedigree
#'
#' Gets minimal pedigree data from database using database internal id
#'
#' @param id integer
#' @author Reinhard Simon
#' @return list of pedigree data
#' @import httr
#' @references \url{http://docs.brapi.apiary.io/#reference/germplasm/germplasm-details-list-by-studydbid/germplasm-pedigree-by-id?console=1}
#' @export
germplasm_pedigree <- function(id = NULL){
  check_id(id)

  rsp <- brapi_GET(paste0("germplasm/", id, "/pedigree?notation=purdue"))
  httr::content(rsp)$result
}
