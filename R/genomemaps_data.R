#' genomemaps_data
#'
#' lists genomemaps_data available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 30
#' @param mapDbId integer; default 0
#' @param linkageGroupId integer; default 0
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapData.md}{github}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @importFrom magrittr '%>%'
#' @family genomemaps
#' @family genotyping
#' @export
genomemaps_data <- function(con = NULL, mapDbId = 0, linkageGroupId = 0,
                            page = 0, pageSize = 30, rclass = "tibble") {
    # TODO: revision; rename: map_data
    brapi::check(con, FALSE, "maps/id/positions")
    brp <- get_brapi(con)
    maps_positions_list <- paste0(brp, "maps/", mapDbId, "/positions/?")
    linkageGroupId <- paste("linkageGroupId=", linkageGroupId, "&",
                            sep = "") %>% paste(collapse = "")
    page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
    pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize,
                                                    "&"), "")
    maps_positions_list <- paste0(maps_positions_list, page, pageSize,
                                  linkageGroupId)
    try({
        res <- brapiGET(maps_positions_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        if (rclass == "vector")
            rclass <- "tibble"
        out <- dat2tbl(res, rclass)
        class(out) <- c(class(out), "brapi_genomemaps_data")
        out
    })
}
