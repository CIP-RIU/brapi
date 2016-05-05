#' studyTypes
#'
#' Gets minimal marker profile data from database using database internal id
#'
#' @param page integer requested page number
#' @param pageSize items per page
#' @import httr
#' @author Reinhard Simon
#' @return list of marker profile ids
#' @import httr
#' @references \url{http://docs.brapi.apiary.io/#reference/germplasm/germplasm-markerprofiles/markerprofiles-by-germplasmdbid?console=1}
#' @export
studyTypes <- function(page = 1, pageSize = 1000) {
  check_id(page)
  check_id(pageSize)


  #TODO implement paging!
  rsp <- brapi_GET(paste0("studyTpes?", "pageSize=",pageSize,"&page=", page, "&"))
  httr::content(rsp)$result
}
