#' ba_observationvariables_details
#'
#' Retrieve variable details on a BrAPI compliant database server.
#'
#' @param con list, brapi connection object
#' @param observationVariableDbId character, the internal database identifier for
#'                                an observation variable of which the details
#'                                are to be retrieved e.g. "MO_123:100002";
#'                                \strong{REQUIRED ARGUMENT} with default: ""
#' @param rclass character, class of the object to be returned; default:
#'               "tibble", possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the variable
#'         details the requested observation variable identifier on the BrAPI
#'         compliant database server.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
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
                                            rclass = c("tibble", "data.frame",
                                                       "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "variables/id")
  check_character(observationVariableDbId)
  check_req(observationVariableDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con)
  callurl <- paste0(brp, "variables/", observationVariableDbId)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
        out <- sov2tbl(res = cont, rclass =  rclass)
    }
    class(out) <- c(class(out), "ba_observationvariables_details")
    show_metadata(resp)
    return(out)
  })
}
