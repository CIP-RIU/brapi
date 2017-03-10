#' ba_studies_observationunits
#'
#' lists studies_observationunits available on a brapi server
#'
#' @param con list, brapi connection object
#' @param rclass character; default: tibble
#' @param observationLevel character; default: plot; alternative: plant
#' @param studyDbId character; default: 1
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ObservationUnitDetails.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_studies_observationunits.R
#' @import tibble
#' @import tidyjson
#' @family studies
#' @family phenotyping
#' @export
ba_studies_observationunits <- function(con = NULL, studyDbId = "1", observationLevel = "plot", rclass = "tibble") {
    ba_check(con, FALSE, "studies/id/observationunits")
    stopifnot(is.character(studyDbId))
    stopifnot(observationLevel %in% c("plot", "plant"))
    check_rclass(rclass)

    brp <- get_brapi(con)
    studies_observationunits_list <- paste0(brp, "studies/", studyDbId, "/observationunits/?")
    observationLevel <- ifelse(observationLevel == "plant", "observationLevel=plant", "observationLevel=plot")
    studies_observationunits_list <- paste0(studies_observationunits_list, observationLevel)

    try({
        res <- brapiGET(studies_observationunits_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        if (rclass %in% c("json", "list")) {
            out <- dat2tbl(res, rclass)
        }
        if (rclass %in% c("tibble", "data.frame")) {
            out <- sou2tbl(res = res, rclass = rclass, observationLevel = observationLevel)
        }
        class(out) <- c(class(out), "ba_studies_observationunits")
        return(out)
    })
}
