#' ba_observationvariables_details
#'
#' lists brapi_variables_details available on a brapi server
#'
#' @param rclass character; default: tibble
#' @param con list; brapi connection object
#' @param observationVariableDbId character; default 'CO_334:0100622'; from test server.
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableDetails.md}{github}
#' @author Reinhard Simon
#' @return rclass as defined
#' @example inst/examples/ex-ba_observationvariables_details.R
#' @import tibble
#' @family observationvariables
#' @family brapicore
#'
#' @export
ba_observationvariables_details <- function(con = NULL, observationVariableDbId = "MO_123:0100621", rclass = "tibble") {
    ba_check(con, FALSE, "variables/id")
    stopifnot(is.character(observationVariableDbId))
    check_rclass(rclass)

    brp <- get_brapi(con)
    brapi_variables_details <- paste0(brp, "variables/", observationVariableDbId)

    try({
        res <- brapiGET(brapi_variables_details, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL

        if (rclass %in% c("json", "list")) {
            out <- dat2tbl(res, rclass)
        }
        if (rclass %in% c("tibble", "data.frame")) {
            out <- sov2tbl(res, rclass, TRUE)
        }
        class(out) <- c(class(out), "ba_observationvariables_details")
        return(out)
    })
}
