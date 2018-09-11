#' ba_observationvariables_datatypes
#'
#' lists variables_datatypes available on a brapi server
#'
#' @param con object; brapi connection object; default = NULL
#' @param rclass character; default: tibble
#'
#' @return rclass as defined
#'
#' @note Tested against: sweetpotatobase, testserver
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ObservationVariables/VariableDataTypeList.md}{github}
#' @family observationvariables
#' @family brapicore
#'
#' @example inst/examples/ex-ba_observationvariables_datatype.R
#'
#' @import tibble
#' @export
ba_observationvariables_datatypes <- function(con = NULL,
                                              rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "variables/datatypes")
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  endpoint <- paste0(brp, "variables/datatypes")
  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = endpoint)

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    if (rclass %in% c("data.frame", "tibble")) {
      colnames(out) <- "variables_datatypes"
    }
    class(out) <- c(class(out), "ba_observationvariables_datatypes")
    show_metadata(res)
    return(out)
  })
}
