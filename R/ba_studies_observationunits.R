#' ba_studies_observationunits
#'
#' lists studies_observationunits available on a brapi server
#'
#' @param con list, brapi connection object
#' @param rclass character; default: tibble
#' @param observationLevel character; default: plot; alternative: plant
#' @param studyDbId character; default: ''
#'
#' @note This call must have set a specific identifier. The default is an empty string.
#'      If not changed to an identifier present in the database this will result in an error.
#'
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ObservationUnitDetails.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_observationunits.R
#' @import tibble
#' @family studies
#' @family phenotyping
#' @export
ba_studies_observationunits <- function(con = NULL,
                                        studyDbId = "",
                                        observationLevel = "plot",
                                        rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls =
             "studies/id/observationunits")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId !="")
  stopifnot(observationLevel %in% c("plot", "plant"))
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  studies_observationunits_list <- paste0(brp, "studies/",
                                      studyDbId, "/observationunits/?")
  observationLevel <- ifelse(observationLevel == "plant",
                        "observationLevel=plant", "observationLevel=plot")
  studies_observationunits_list <- paste0(
    studies_observationunits_list, observationLevel)
  try({
    res <- brapiGET(url = studies_observationunits_list, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- sou2tbl(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_observationunits")
    show_metadata(res)
    return(out)
  })
}
