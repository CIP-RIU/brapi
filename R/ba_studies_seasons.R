#' ba_studies_seasons
#'
#' lists the studies seasons and years
#'
#' @param con list, brapi connection object
#' @param year integer
#' @param page integer requested page number
#' @param pageSize items per page
#' @param rclass character; one of tibble (default), json, list or data.frame
#' @import httr
#' @author Reinhard Simon
#' @return data.frame
#' @example inst/examples/ex-ba_studies_seasons.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListSeasons.md}{github}
#' @family studies
#' @family phenotyping
#' @export
ba_studies_seasons <- function(con = NULL,
                               year = 0,
                               page = 0,
                               pageSize = 1000,
                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "seasons")
  brp <- get_brapi(con = con)
  stopifnot(is.numeric(year))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  seasons_list <- paste0(brp, "seasons/?")
  year <- ifelse(year != 0, paste0("year=", year, "&"), "")
  page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  seasons_list <- paste0(seasons_list, page, pageSize, year)
  try({
    res <- brapiGET(url = seasons_list, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    class(out) <- c(class(out), "ba_studies_seasons")
    return(out)
  })
}
