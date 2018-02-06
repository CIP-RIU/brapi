#' ba_studies_layout
#'
#' lists studies_layout available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param studyDbId character; default: 1
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/PlotLayoutDetails.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_layout.R
#' @import tibble
#' @family studies
#' @family phenotyping
#' @export
ba_studies_layout <- function(con = NULL,
                              studyDbId = "1",
                              rclass = "tibble") {
  ba_check(con = con, verbose =  FALSE, brapi_calls = "studies/id/layout")
  stopifnot(is.character(studyDbId))
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  studies_layout_list <- paste0(brp, "studies/", studyDbId, "/layout/")
  try({
    res <- brapiGET(url = studies_layout_list, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- lyt2tbl(res = res, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_layout")
    show_metadata(con, res)
    return(out)
  })
}
