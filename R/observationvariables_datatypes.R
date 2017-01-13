#' observationvariables_datatypes
#'
#' lists variables_datatypes available on a brapi server
#'
#' @param con object; brapi connection object; default = NULL
#' @param rclass string; default: tibble
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableDataTypeList.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family observationvariables
#' @family brapicore
#' @export
observationvariables_datatypes <- function(con = NULL, rclass = "tibble") {
    brapi::check(con, FALSE, "variables/datatypes")
    brp <- get_brapi(con)
    variables_datatypes_list = paste0(brp, "variables/datatypes/")

    try({
        res <- brapiGET(variables_datatypes_list, con = con)
        res <- httr::content(res, "text", encoding = "UTF-8")
        out = dat2tbl(res, rclass)
        if (rclass %in% c("data.frame", "tibble")) {
            colnames(out) = "variables_datatypes"
        }
        class(out) = c(class(out), "brapi_observationvariables_datatypes")
        out
    })
}
