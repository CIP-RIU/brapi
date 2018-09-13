#' ba_observationvariables_details
#'
#' lists brapi_variables_details available on a brapi server
#'
#' @param con list; brapi connection object
#' @param observationVariableDbId character; \strong{REQUIRED ARGUMENT} with default ''.
#' @param rclass character; default: tibble
#'
#' @return rclass as defined
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ObservationVariables/VariableDetails.md}{github}
#'
#' @family observationvariables
#' @family brapicore
#'
#' @example inst/examples/ex-ba_observationvariables_details.R
#' @import tibble
#' @export
ba_observationvariables_details <- function(con = NULL,
                                    observationVariableDbId = "",
                                    rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "variables/id")
  check_req(observationVariableDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con)
  callurl <- paste0(brp, "variables/", observationVariableDbId)

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
        out <- sov2tbl(res = res2, rclass =  rclass)
    }
    class(out) <- c(class(out), "ba_observationvariables_details")
    show_metadata(res)
    return(out)
  })
}
