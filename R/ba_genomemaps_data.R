#' ba_genomemaps_data
#'
#' markers ordered by linkageGroup and position
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 30
#' @param mapDbId character; default 0
#' @param linkageGroupId character; default 0
#' @example inst/examples/ex-ba_genomemaps_data.R
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
ba_genomemaps_data <- function(con = NULL, mapDbId = "0", linkageGroupId = "0", page = 0,
                               pageSize = 30, rclass = "tibble") {

    ba_check(con, FALSE, "maps/id/positions")
    stopifnot(is.character(mapDbId))
    stopifnot(is.character(linkageGroupId))
    check_paging(pageSize, page)
    check_rclass(rclass)

    brp <- get_brapi(con)
    maps_positions_list <- paste0(brp, "maps/", mapDbId, "/positions/?")
    linkageGroupId <- paste("linkageGroupId=", linkageGroupId, "&", sep = "") %>%
      paste(collapse = "")
    page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
    pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
    maps_positions_list <- paste0(maps_positions_list, page, pageSize, linkageGroupId)
    try({
        res <- brapiGET(maps_positions_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        if (rclass == "vector")
            rclass <- "tibble"
        out <- dat2tbl(res, rclass)
        class(out) <- c(class(out), "ba_genomemaps_data")
        out
    })
}
