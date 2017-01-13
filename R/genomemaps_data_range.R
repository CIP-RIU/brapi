#' genomemaps_data_range
#'
#' lists genomemaps_data_range available on a brapi server

#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 30
#' @param mapDbId integer; default 0
#' @param linkageGroupId integer; default 0
#' @param min integer; default 0
#' @param max integer; default 1000
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapDataByRangeOnLinkageGroup.md}
#' @return rclass as defined
#' @import tibble
#' @importFrom magrittr '%>%'
#' @family genomemaps
#' @family genotyping
#' @export
genomemaps_data_range <- function(con = NULL, mapDbId = 1, linkageGroupId = 1, min = 1, max = 1000, page = 0, 
    pageSize = 30, rclass = "tibble") {
    # TODO: revision; rename: map_data_range
    brapi::check(con, FALSE, "maps/id/positions/id")
    
    brp <- get_brapi(con)
    maps_positions_range_list = paste0(brp, "maps/", mapDbId, "/positions/", linkageGroupId, "/?")
    
    amin = ifelse(is.numeric(min), paste0("min=", min, "&"), "")
    amax = ifelse(is.numeric(max), paste0("max=", max, "&"), "")
    
    page = ifelse(is.numeric(page), paste0("page=", page, "&"), "")
    pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
    
    maps_positions_range_list = paste0(maps_positions_range_list, amin, amax, page, pageSize, linkageGroupId)
    
    # message(maps_positions_range_list)
    try({
        res <- brapiGET(maps_positions_range_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        if (rclass == "vector") 
            rclass = "tibble"
        out = dat2tbl(res, rclass)
        class(out) = c(class(out), "brapi_genomemaps_data_range")
        out
    })
}
