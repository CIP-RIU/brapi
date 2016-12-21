#' maps
#'
#' lists maps available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param species string; default:
#' @param type string, default: all
#' @param page integer; default 0
#' @param pageSize integer; default 30
#'
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/call-search}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family genotyping
#' @export
maps <- function(species = "all", type = "all", page = 0, pageSize = 30, rclass = "tibble") {
  brapi::check(FALSE, "maps")
  brp <- get_brapi()
  maps_list = paste0(brp, "maps/")
  if (is.numeric(page) & is.numeric(pageSize)) {
    maps_list = paste0(maps_list, "?page=", page, "&pageSize=", pageSize)
  }

  if(species != "all"){
    maps_list = paste0(maps_list, "&species=", species)
  }


  if(type != "all"){
    maps_list = paste0(maps_list, "&type=", type)
  }

  try({
    res <- brapiGET(maps_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    if(rclass == "vector") rclass = "tibble"
    dat2tbl(res, rclass)
  })
}
