#' maps_positions
#'
#' lists maps_positions available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 30
#' @param mapDbId integer; default 0
#' @param linkageGroupId integer; default 0
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
maps_positions <- function(mapDbId = 0, linkageGroupId= 0,
                           page = 0, pageSize = 30, rclass = "tibble") {
  brapi::check(FALSE, "maps/id/positions")
  brp <- get_brapi()
  maps_positions_list = paste0(brp, "maps/", mapDbId ,"/positions/?")

  #if(is.vector(linkageGroupId)) linkageGroupId = paste(linkageGroupId, collapse = ",")
  linkageGroupId = paste("linkageGroupId=", linkageGroupId, "&", sep="") %>% paste(collapse = "")

  page = ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  maps_positions_list = paste0(maps_positions_list, page, pageSize, linkageGroupId)

  #message(maps_positions_list)
  try({
    res <- brapiGET(maps_positions_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    if(rclass == "vector") rclass = "tibble"
    dat2tbl(res, rclass)
  })
}
