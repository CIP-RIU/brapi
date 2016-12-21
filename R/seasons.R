#' seasons
#'
#' lists the seasons and years
#'
#' @param year integer
#' @param page integer requested page number
#' @param pageSize items per page
#' @param rclass character; one of tibble (default), json, list or data.frame
#' @import httr
#' @author Reinhard Simon
#' @return data.frame
#' @references \url{http://docs.brapi.apiary.io/#reference/0/list-seasons/list-seasons-or-years}
#' @family brapi_call
#' @family core
#' @family experiments
#' @export
seasons <- function(year = NULL, page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(FALSE, "seasons")
  brp <- get_brapi()
  seasons_list = paste0(brp, "seasons/?")

  year = ifelse(is.numeric(year), paste0("year=", year, "&"), "")
  page = ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  seasons_list = paste0(seasons_list, page, pageSize, year)

  try({
    res <- brapiGET(seasons_list)
    res <- httr::content(res, "text", encoding = "UTF-8")

    dat2tbl(res, rclass)
  })
}
