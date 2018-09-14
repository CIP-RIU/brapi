#' ba_observationvariables
#'
#' Retrieve a list of observation variables available on a BrAPI compliant
#' database server.
#'
#' @param con list, brapi connection object
#' @param traitClass character, variable's trait class e.g. "phenological";
#'                   default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned; default:
#'               "tibble", possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the observation
#'         variables available on the BrAPI compliant database server.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ObservationVariables/VariableList.md}{github}
#'
#' @family observationvariables
#' @family brapicore
#'
#' @example inst/examples/ex-ba_observationvariables.R
#'
#' @import tibble
#' @export
ba_observationvariables <- function(con = NULL,
                                    traitClass = "",
                                    pageSize = 1000,
                                    page = 0,
                                    rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "variables")
  check_character(traitClass)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("variables")
  callurl <- get_endpoint(pointbase = brp,
                          traitClass = traitClass,
                          pageSize = pageSize,
                          page = page)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
        out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
        out <- sov2tbl(res = cont, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_observationvariables")
    show_metadata(resp)
    return(out)
  })
}
