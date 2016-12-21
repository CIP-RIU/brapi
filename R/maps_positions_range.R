#' maps_positions_range
#'
#' lists maps_positions_range available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 30
#' @param mapDbId integer; default 0
#' @param linkageGroupId integer; default 0
#' @param min integer; default 0
#' @param max integer; default 1000
#'
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/call-search}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @importFrom magrittr '%>%'
#' @family brapi_call
#' @family genotyping
#' @export
maps_positions_range <- function(mapDbId = 0, linkageGroupId= 0,
                                 min = 0, max = 1000,
                           page = 0, pageSize = 30, rclass = "tibble") {
  brapi::check(FALSE, "maps/id/positions/id")
  brp <- get_brapi()
  maps_positions_range_list = paste0(brp, "maps/",
                                     mapDbId ,"/positions/",
                                     linkageGroupId, "/?")

  amin = ifelse(is.numeric(min), paste0("min=", min, "&"), "")
  amax = ifelse(is.numeric(max), paste0("max=", max, "&"), "")

  page = ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  maps_positions_range_list = paste0(maps_positions_range_list, amin, amax, page, pageSize, linkageGroupId)

  #message(maps_positions_range_list)
  try({
    res <- brapiGET(maps_positions_range_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    if(rclass == "vector") rclass = "tibble"
    dat2tbl(res, rclass)
  })
}
