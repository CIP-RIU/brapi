#' ba_locations
#'
#' lists locations available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param locationType character, list of data types
#' @param page integer; default 0
#' @param pageSize integer; default 100
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Locations/ListLocations.md}{github}
#' @example inst/examples/ex-ba_locations.R
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
# @family phenotyping
#' @export
ba_locations <- function(con = NULL, locationType = "all", page = 0, pageSize = 100, rclass = "tibble") {
    ba_check(con, FALSE, "locations")
    stopifnot(is.character(locationType))
    check_paging(pageSize, page)
    check_rclass(rclass)

    brp <- get_brapi(con)
    locations_list <- paste0(brp, "locations/?")
    plocationType <- ifelse(locationType != "all", paste0("locationType=", locationType, "&"), "")
    ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
    ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
    if (pageSize == 1e+06) {
        ppage <- ""
        ppageSize <- ""
    }

    locations_list <- paste0(locations_list, plocationType, ppageSize, ppage)

    try({
        res <- brapiGET(locations_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        if (rclass %in% c("json", "list")) {
            out <- dat2tbl(res, rclass)
        }
        if (rclass %in% c("tibble", "data.frame")) {
            out <- loc2tbl(res, rclass, con)


        }
        if (!is.null(out))
            class(out) <- c(class(out), "ba_locations")
        return(out)
    })
}
