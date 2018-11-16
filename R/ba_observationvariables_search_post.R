#' ba_observationvariables_search_post
#'
#' Search for observation variables on a brapi server via a POST method.
#'
#' @param con list, brapi connection object
#' @param datatypes  character vector, filter the search results by a list of
#'                   scale data types, supplied as a comma separated character
#'                   vector e.g. c("numeric"); default: ""
#' @param methodDbIds  character vector, filter the search results by a list of
#'                     methods, supplied as a comma separated character vector
#'                     of internal program database identifiers e.g.
#'                     c("method-1", "method-2"); default: ""
#' @param names  character vector, search for observation variables by human
#'               readable observation variable names, supplied as a comma
#'               separated character vector e.g. c("caro_spectro"); default: ""
#' @param observationVariableDbIds  character vector, filter search results of
#'                                  observation variables by specified
#'                                  observation variable internal database
#'                                  identifiers, supplied as a comma separated
#'                                  character vector e.g. c("obs-variable-id1",
#'                                  "obs-variable-id1"); default: ""
#' @param ontologyXrefs  character vector, filter search results of observation
#'                       variables using ontology cross references, supplied as
#'                       a comma separated character vector e.g. c("CO:123",
#'                       "CO:456"); default: ""
#' @param ontologyDbIds  character vector, filter search results of observation
#'                       variables by ontology internal database identifiers,
#'                       supplied as a comma separated character vector e.g. c("
#'                       CO_334:0100632"); default: ""
#' @param scaleDbIds  chararcter vector, filter search results of observation
#'                    variables by specified scale internal database identifiers
#'                    , supplied as a comma separated character vector e.g. c("
#'                    scale-1", "scale-2"); default: ""
#' @param traitClasses character vector, filter search results of observation
#'                     variables by trait classes, supplied as a comma separated
#'                     character vector e.g. c("Phenological", "Physiological");
#'                     default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by \code{rclass} containing the
#'         observation variables fulfilling the search criteria.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/ObservationVariables/VariableSearch.md}{github}
#' @example inst/examples/ex-ba_observationvariables_search_post.R
#' @import httr
#' @importFrom utils str
#' @export
ba_observationvariables_search_post <- function(con = NULL,
                                                datatypes = "",
                                                methodDbIds = "",
                                                names = "",
                                                observationVariableDbIds = "",
                                                ontologyXrefs = "",
                                                ontologyDbIds = "",
                                                scaleDbIds = "",
                                                traitClasses = "",
                                                pageSize = 1000,
                                                page = 0,
                                                rclass = c("tibble", "data.frame",
                                                           "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "variables-search")
  check_character(datatypes, methodDbIds, names, observationVariableDbIds, ontologyXrefs,
                  ontologyDbIds, scaleDbIds, traitClasses)
  rclass <- match.arg(rclass)
  callurl <- get_brapi(con) %>% paste0("variables-search")

  body <- get_body( datatypes = datatypes,
                    methodDbIds = methodDbIds,
                    names = names,
                    observationVariableDbIds = observationVariableDbIds,
                    ontologyXrefs = ontologyXrefs,
                    ontologyDbIds = ontologyDbIds,
                    pageSize = pageSize,
                    page = page,
                    scaleDbIds = scaleDbIds,
                    traitClasses = traitClasses)

  try({
    resp <- brapiPOST(url = callurl, body = body, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- sov2tbl(res = cont, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_observationvariables_search_post")
    show_metadata(resp)
    return(out)
  })
}
