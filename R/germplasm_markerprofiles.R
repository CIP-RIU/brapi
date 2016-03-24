
#' germplasm_markerprofiles
#'
#' Gets minimal marker profile data from database using database internal id
#'
#' @param id integer
#' @author Reinhard Simon
#' @return list of marker profile ids
#' @import httr
#' @references \url{http://docs.brapi.apiary.io/#reference/germplasm/germplasm-markerprofiles/markerprofiles-by-germplasmdbid?console=1}
#' @export
germplasm_markerprofiles <- function(id = NULL){
  check_id(id)

  rsp <- brapi_GET(paste0("germplasm/", id, "/markerprofiles?"))
  httr::content(rsp)$result
}
