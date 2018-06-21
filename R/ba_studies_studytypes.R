#' ba_studies_studytypes
#'
#' lists studies_studytypes available on a brapi server
#'
#' @note Tested against: sweetpotatobase
#'
#' @param con list, brapi connection object
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListStudyTypes.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_studytypes.R
#' @import tibble
#' @family studies
#' @family phenotyping
#' @export
ba_studies_studytypes <- function(con = NULL,
                                  page = 0,
                                  pageSize = 1000,
                                  rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studytypes")
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  pstudyTypes <- paste0(brp, "studytypes/?")
  page <- ifelse(page < 0, paste0("page=", page, "&"), "")
  pageSize <- ifelse(pageSize < 0,
                     paste0("pageSize=", pageSize, "&"), "")
  pstudyTypes <- paste0(pstudyTypes, pageSize, page)
  try({
    res <- brapiGET(url = pstudyTypes, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_studies_studytypes")
    show_metadata(res)
    return(out)
  })
}
