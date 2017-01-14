#' observationvariables
#'
#' lists brapi_variables available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param con object; brapi connection object
#' @param page integer; default 0
#' @param pageSize integer; defautlt 1000
#' @param traitClass string; default 'all'
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableList.md}
#' @return rclass as defined
#' @import tibble
#' @family observationvariables
#' @family brapicore
#'
#' @export
observationvariables <- function(con = NULL, traitClass = "all", page = 0, pageSize = 1000, rclass = "tibble") {
    brapi::check(con, FALSE, "variables")

    brp <- get_brapi(con)
    brapi_variables <- paste0(brp, "variables/?")

    ptraitClass <- paste0("traitClass=", traitClass, "&")
    ppage <- paste0("page=", page, "")
    ppageSize <- paste0("pageSize=", pageSize, "&")
    brapi_variables <- paste0(brapi_variables, ptraitClass, ppageSize, ppage)

    try({
        res <- brapiGET(brapi_variables, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- NULL
        if (!rclass %in% c("json", "list", "tibble", "data.frame")) {
            rclass <- "json"
        }

        if (rclass %in% c("json", "list")) {
            out <- dat2tbl(res, rclass)
        }
        if (rclass %in% c("tibble", "data.frame")) {
            out <- sov2tbl(res, rclass, TRUE)
        }
        class(out) <- c(class(out), "brapi_observationvariables")
        out
    })
}
