#' ba_observationvariables_ontologies
#'
#' Retrieve a list of observation variable ontologies available available on a
#' BrAPI compliant database server.
#'
#'
#' @param con list, brapi connection object
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned; default:
#'               "tibble", possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the observation
#'         variable ontologies on the BrAPI compliant database server.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ObservationVariables/VariableOntologyList.md}{github}

#' @family observationvariables
#' @family brapicore
#'
#' @example inst/examples/ex-ba_observationvariables_ontologies.R
#'
#' @import tibble
#' @export
ba_observationvariables_ontologies <- function(con = NULL,
                                               pageSize = 1000,
                                               page = 0,
                                               rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "ontologies")
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("ontologies")
  callurl <- get_endpoint(pointbase = brp, pageSize = pageSize, page = page)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = cont, rclass = rclass)
    class(out) <- c(class(out), "ba_observationvariables_ontologies")
    show_metadata(resp)
    return(out)
  })
}
