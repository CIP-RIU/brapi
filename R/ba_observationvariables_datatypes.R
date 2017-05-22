#' ba_observationvariables_datatypes
#'
#' lists variables_datatypes available on a brapi server
#'
#' @param con object; brapi connection object; default = NULL
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableDataTypeList.md}{github}
#' @return rclass as defined
#' @example inst/examples/ex-ba_observationvariables_datatype.R
#' @import tibble
#' @import tidyjson
#' @family observationvariables
#' @family brapicore
#' @export
ba_observationvariables_datatypes <- function(con = NULL,
                                              rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "variables/datatypes")
  check_rclass(rclass = rclass)
  brp <- get_brapi(brapi = con)
  variables_datatypes_list <- paste0(brp, "variables/datatypes/")
  try({
    res <- brapiGET(url = variables_datatypes_list, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    if (rclass %in% c("data.frame", "tibble")) {
      colnames(out) <- "variables_datatypes"
    }
    class(out) <- c(class(out), "ba_observationvariables_datatypes")
    return(out)
  })
}
