#' ba_studies_details
#'
#' Gets studies details given an id.
#'
#' @param con brapi connection object
#' @param rclass character; tibble
#' @param studiesDbId character; default 0; an internal ID for a studies
#' @import tidyjson
#' @import dplyr
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/StudyDetails.md}{github}
#' @return data.frame
#' @example inst/examples/ex-ba_studies_details.R
#' @family studies
#' @family phenotyping
#' @export
ba_studies_details <- function(con = NULL, studiesDbId = "0", rclass = "tibble") {
    ba_check(con, FALSE, "studies/id")
    stopifnot(is.character(studiesDbId))
    check_rclass(rclass)

    studies <- paste0(get_brapi(con), "studies/", studiesDbId, "/")
    try({
        res <- brapiGET(studies, con = con)
        out <- NULL
        if (is.ba_status_ok(res)) {
            res <- httr::content(res, "text", encoding = "UTF-8")
            if (rclass %in% c("json", "list"))
                out <- dat2tbl(res, rclass)
            if (rclass %in% c("data.frame", "tibble"))
                out <- stdd2tbl(res, rclass)
            class(out) <- c(class(out), "ba_studies_details")
        }
        return(out)
    })
}
