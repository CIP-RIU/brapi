#' ba_studies_observationvariables
#'
#' lists  @param con brapi connection object available on a brapi server
#'
#' @param con list, brapi connection object
#' @param rclass character; default: tibble
#' @param studyDbId character; default: 1
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyObservationVariables.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_observationvariables.R
#' @import tibble
#' @import tidyjson
#' @family studies
#' @family phenotyping
#' @export
ba_studies_observationvariables <- function(con = NULL, studyDbId = "1", rclass = "tibble") {
    ba_check(con, FALSE, "studies/id/observationVariables")
    stopifnot(is.character(studyDbId))
    check_rclass(rclass)

    brp <- get_brapi(con)
    studies_observationVariables_list <- paste0(brp, "studies/", studyDbId, "/observationVariables/?")

    try({
        res <- brapiGET(studies_observationVariables_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        if (rclass %in% c("json", "list")) {
            out <- dat2tbl(res, rclass)
        }
        if (rclass %in% c("tibble", "data.frame")) {
            out <- sov2tbl(res, rclass)
        }
        class(out) <- c(class(out), "ba_studies_observationvariables")
        return(out)
    })
}
