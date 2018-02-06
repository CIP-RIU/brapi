#' ba_studies_details
#'
#' Gets studies details given an id.
#'
#' @param con brapi connection object
#' @param rclass character; tibble
#' @param studiesDbId character; default 0; an internal ID for a studiess
#' @import dplyr
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyDetails.md}{github}
#' @return data.frame
#' @example inst/examples/ex-ba_studies_details.R
#' @family studies
#' @family phenotyping
#' @export
ba_studies_details <- function(con = NULL,
                               studiesDbId = "0",
                               rclass = "tibble") {

  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id")
  stopifnot(is.character(studiesDbId))
  check_rclass(rclass = rclass)
  studies <- paste0(get_brapi(con = con), "studies/", studiesDbId, "/")
  try({
    res <- brapiGET(url = studies, con = con)
    out <- NULL
    if (is.ba_status_ok(res)) {
      res <- httr::content(x = res, as = "text", encoding = "UTF-8")
      if (rclass %in% c("json", "list")) {
        out <- dat2tbl(res = res, rclass = rclass)
      }
      if (rclass %in% c("data.frame", "tibble")) {
        out <- stdd2tbl(res = res, rclass = rclass)
      }
      class(out) <- c(class(out), "ba_studies_details")
    }
    show_metadata(con, res)
    return(out)
  })
}
