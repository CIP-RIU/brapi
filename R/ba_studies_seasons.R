#' ba_studies_seasons
#'
#' Retrieve all seasons (or years) on a brapi server.
#'
#' @param con list, brapi connection object
#' @param year integer, filter by specified year; default: 0
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing all seasons (or
#'         years).
#'
#' @note Tested against: sweetpotato, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Seasons_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_seasons.R
#' @import httr
#' @export
ba_studies_seasons <- function(con = NULL,
                               year = 0,
                               pageSize = 1000,
                               page = 0,
                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "seasons")
  stopifnot(is.numeric(year))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  seasons_list <- paste0(brp, "seasons?")
  pyear <- ifelse(year != 0, paste0("year=", year, "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                   pageSize, "&"), "")
  if (page == 0 & pageSize == 1000) {
    ppage <- ""
    ppageSize <- ""
  }
  seasons_list <- sub(pattern = "[/?&]$",
                      replacement = "",
                      x = paste0(seasons_list,
                                 pyear,
                                 ppageSize,
                                 ppage))
  try({
    res <- brapiGET(url = seasons_list, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_studies_seasons")
    show_metadata(res)
    return(out)
  })
}
