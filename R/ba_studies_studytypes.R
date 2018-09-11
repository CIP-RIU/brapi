#' ba_studies_studytypes
#'
#' lists studies_studytypes available on a brapi server
#'
#' @param con list, brapi connection object
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @return rclass as defined
#'
#' @note Tested against: sweetpotatobase, testserver
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListStudyTypes.md}{github}
#' @family studies
#' @family phenotyping
#'
#' @example inst/examples/ex-ba_studies_studytypes.R
#' @import tibble

#' @export
ba_studies_studytypes <- function(con = NULL,
                                  page = 0,
                                  pageSize = 1000,
                                  rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studytypes")
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  endpoint <- paste0(brp, "studytypes?")
  ppage <- get_ppages(pageSize, page)
  # modify brapi call url to include pagination
  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = paste0(endpoint,
                            ppage$pageSize,
                            ppage$page))

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_studies_studytypes")
    show_metadata(res)
    return(out)
  })
}
