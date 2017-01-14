#' studies_observationlevels
#'
#' lists studies_observationlevels available in a database
#'
#' @param con brapi connection object
#' @param rclass character; default is FALSE; whether to display the raw list object or not
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
#' @family studies
#' @family phenotyping
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListObservationLevels.md}
#' @export
studies_observationlevels <- function(con = NULL, rclass = "vector") {
    brapi::check(con, FALSE, "observationLevels")
    observationLevels_List <- paste0(get_brapi(con), "observationLevels")
    try({
        res <- brapiGET(observationLevels_List, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- dat2tbl(res, rclass)
        class(out) <- c(class(out), "brapi_studies_observationlevels")
        out
    })
}
