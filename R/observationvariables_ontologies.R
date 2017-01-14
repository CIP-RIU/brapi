#' observationvariables_ontologies
#'
#' lists variables_datatypes available on a brapi server
#'
#' @param con object; brapi connection object; default = NULL
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; defautlt 1000
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableOntologyList.md}
#' @return rclass as defined
#' @import tibble
#' @family observationvariables
#' @family brapicore
#' @export
observationvariables_ontologies <- function(con = NULL, page = 0, pageSize = 1000, rclass = "tibble") {
    brapi::check(con, FALSE, "ontologies")
    brp <- get_brapi(con)
    variables_ontologies <- paste0(brp, "ontologies/?")

    ppage <- paste0("page=", page, "")
    ppageSize <- paste0("pageSize=", pageSize, "&")
    variables_ontologies <- paste0(variables_ontologies, ppageSize, ppage)

    try({
        res <- brapiGET(variables_ontologies, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- dat2tbl(res, rclass)
        class(out) <- c(class(out), "brapi_observationvariables_ontologies")
        out
    })
}
