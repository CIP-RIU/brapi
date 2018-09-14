#' ba_observationvariables_search_post
#'
#' lists the breeding observationvariables
#'
#'
#' @param con brapi list; connection object
#' @param datatypes  vector of character; default: ''
#' @param methodDbIds  vector of character; default: ''
#' @param names  vector of character; default: ''
#' @param observationVariableDbIds  vector of character; default: ''
#' @param ontologyXrefs  vector of character; default: ''
#' @param ontologyDbIds  vector of character; default: ''
#' @param page integer; default: 0
#' @param pageSize integer, default: 1000
#' @param scaleDbIds  vector of character; default: ''
#' @param traitClasses vector of character; default: ''
#' @param rclass character; default: tibble
#'
#' @import httr
#' @importFrom utils str
#' @author Reinhard Simon
#' @return rclass
#' @example inst/examples/ex-ba_observationvariables_search_post.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableSearch.md}{github}
#' @family brapicore
#' @export
ba_observationvariables_search_post <- function(con = NULL,
                                           datatypes = "",
                                           methodDbIds = "",
                                           names = "",
                                           observationVariableDbIds = "",
                                           ontologyXrefs = "",
                                           ontologyDbIds = "",
                                           page = 0,
                                           pageSize = 1000,
                                           scaleDbIds = "",
                                           traitClasses = "",
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
                    page = page,
                    pageSize = pageSize,
                    scaleDbIds = scaleDbIds,
                    traitClasses = traitClasses)


  try({
    resp <- brapiPOST(url = callurl, body = body, con = con)
    cont<- httr::content(x = resp, as = "text", encoding = "UTF-8")
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
