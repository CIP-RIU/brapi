#' ba_studies_observationvariables
#'
#' lists  @param con brapi connection object available on a brapi server
#'
#' @note This call must have set a specific identifier. The default is an empty string.
#'      If not changed to an identifier present in the database this will result in an error.
#'
#'
#' @param con list, brapi connection object
#' @param rclass character; default: tibble
#' @param studyDbId character; default: ''
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyObservationVariables.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_observationvariables.R
#' @import tibble
#' @family studies
#' @family phenotyping
#' @export
ba_studies_observationvariables <- function(con = NULL,
                                            studyDbId = "",
                                            rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls =
             "studies/id/observationVariables")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != "")
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  studies_observationVariables_list <- paste0(brp, "studies/",
                                      studyDbId, "/observationVariables/?")
  try({
    res <- brapiGET(url = studies_observationVariables_list, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- sov2tbl(res = res, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_observationvariables")
    show_metadata(con, res)
    return(out)
  })
}
