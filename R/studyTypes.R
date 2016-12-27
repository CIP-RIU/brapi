#' studyTypes
#'
#' lists studyTypes available on a brapi server
#'
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#' @param rclass string; default: tibble
#'
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/studyTypes}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family phenotyping
#' @family access
#' @export
studyTypes <- function(page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(FALSE, "studyTypes")
  brp <- get_brapi()
  pstudyTypes = paste0(brp, "studyTypes/?")

  page = ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  pstudyTypes = paste0(pstudyTypes, pageSize, page)
  try({
    res <- brapiGET(pstudyTypes)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = dat2tbl(res, rclass)

    out
  })
}
