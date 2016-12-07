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
#' @export
seasons <- function(year = NULL, page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(FALSE)
  brp <- get_brapi()
  if(is.null(page) & is.null(pageSize)) {
    seasons_list = paste0(brp, "seasons")
  }
  if (is.numeric(page) & is.numeric(pageSize)) {
    seasons_list = paste0(brp, "seasons?page=", page, "&pageSize=", pageSize)
  }
  if (!is.null(year)) {
    seasons_list = paste0(seasons_list, "&year=", year)
  }

  tryCatch({
    res <- brapiGET(seasons_list)
    res <- httr::content(res, "text", encoding = "UTF-8")

    dat2tbl(res, rclass)
  }, error = function(e){
    NULL
  })
}
