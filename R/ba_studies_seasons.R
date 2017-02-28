#' ba_studies_seasons
#'
#' lists the studies seasons and years
#'
#' @param con brapi connection object
#' @param year integer
#' @param page integer requested page number
#' @param pageSize items per page
#' @param rclass character; one of tibble (default), json, list or data.frame
#' @import httr
#' @author Reinhard Simon
#' @return data.frame
#' @example inst/examples/ex-ba_studies_seasons.R
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListSeasons.md}
#' @family studies
#' @family phenotyping
#' @export
ba_studies_seasons <- function(con = NULL, year = NULL, page = 0, pageSize = 1000, rclass = "tibble") {
    ba_check(con, FALSE, "seasons")
    brp <- get_brapi(con)
    seasons_list <- paste0(brp, "seasons/?")

    year <- ifelse(is.numeric(year), paste0("year=", year, "&"), "")
    page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
    pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

    seasons_list <- paste0(seasons_list, page, pageSize, year)

    try({
        res <- brapiGET(seasons_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")

        out <- dat2tbl(res, rclass)
        class(out) <- c(class(out), "ba_studies_seasons")
        return(out)
    })
}
