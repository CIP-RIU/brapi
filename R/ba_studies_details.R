#' ba_studies_details
#'
#' Gets studies details given an id.
#'
#' This function must have set a specific study identifier. The default is an empty
#' string. If not changed to an study identifier present in the database this will
#' result in an error.
#'
#' @note Tested against: sweetpotatobase, BMS
#'
#' @param con brapi connection object
#' @param rclass character; default: "tibble" possible other values: "json"/"list"/"data.frame"
#' @param studyDbId character; default ''; an internal ID for a study
#' @import dplyr
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyDetails.md}{github}
#' @return data.frame
#' @example inst/examples/ex-ba_studies_details.R
#' @family studies
#' @family phenotyping
#' @export
ba_studies_details <- function(con = NULL,
                               studyDbId = "",
                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != "")
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  studies <- sub("[/?&]$",
                 "",
                 paste0(brp, "studies/", studyDbId, "/"))
  try({
    res <- brapiGET(url = studies, con = con)
    out <- NULL
    if (is.ba_status_ok(resp = res)) {
      res <- httr::content(x = res, as = "text", encoding = "UTF-8")
      if (rclass %in% c("json", "list")) {
        out <- dat2tbl(res = res, rclass = rclass)
      }
      if (rclass %in% c("data.frame", "tibble")) {
        out <- stdd2tbl(res = res, rclass = rclass)
      }
      class(out) <- c(class(out), "ba_studies_details")
    }
    #show_metadata(con, res)
    return(out)
  })
}
