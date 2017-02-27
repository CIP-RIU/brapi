#' studies_observationvariables
#'
#' lists  @param con brapi connection object available on a brapi server
#'
#' @param con brapi connection object
#' @param rclass string; default: tibble
#' @param studyDbId character; default: 1
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyObservationVariables.md}{github}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family studies
#' @family phenotyping
#' @export
studies_observationvariables <- function(con = NULL, studyDbId = 1, rclass = "tibble") {
    brapi::check(con, FALSE, "studies/id/observationVariables")
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
        class(out) <- c(class(out), "brapi_studies_observationvariables")
        return(out)
    })
}
