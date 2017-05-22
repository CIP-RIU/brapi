#' ba_observationvariables_search
#'
#' lists the breeding observationvariables
#'
#'
#' @param con brapi list; connection object
#' @param observationVariableDbIds  vector of character; default: any
#' @param ontologyXrefs  vector of character; default: any
#' @param ontologyDbIds  vector of character; default: any
#' @param methodDbIds  vector of character; default: any
#' @param scaleDbIds  vector of character; default: any
#' @param names  vector of character; default: any
#' @param datatypes  vector of character; default: any
#' @param traitClasses vector of character; default: any
#' @param rclass character; default: tibble
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @example inst/examples/ex-ba_observationvariables_search.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableSearch.md}{github}
#' @family brapicore
#' @export
ba_observationvariables_search <- function(con = NULL,
                                           observationVariableDbIds = "any",
                                           ontologyXrefs = "any",
                                           ontologyDbIds = "any",
                                           methodDbIds = "any",
                                           scaleDbIds = "any",
                                           names = "any",
                                           datatypes = "any",
                                           traitClasses = "any",
                                           rclass = "tibble") {
    ba_check(con = con, verbose = FALSE, brapi_calls = "variables-search")
    stopifnot(is.character(observationVariableDbIds))
    stopifnot(is.character(ontologyXrefs))
    stopifnot(is.character(ontologyDbIds))
    stopifnot(is.character(methodDbIds))
    stopifnot(is.character(scaleDbIds))
    stopifnot(is.character(names))
    stopifnot(is.character(datatypes))
    stopifnot(is.character(traitClasses))
    check_rclass(rclass = rclass)
    brp <- get_brapi(brapi = con)
    pvariables <- paste0(brp, "variables-search/")
    try({
      res <- brapiPOST(pvariables, body, con = con)
      body <- list(observationVariableDbIds = observationVariableDbIds %>% as.list(),
                   ontologyXrefs = ontologyXrefs,
                   ontologyXrefs = ontologyXrefs,
                   ontologyXrefs = ontologyXrefs,
                   scaleDbIds = scaleDbIds,
                   names = names,
                   datatypes = datatypes,
                   traitClasses = traitClasses)
      res <- brapiPOST(url = pvariables, body = body, con = con)
      res <- httr::content(x = res, as = "text", encoding = "UTF-8")
      out <- NULL
      if (rclass %in% c("json", "list")) {
        out <- dat2tbl(res = res, rclass = rclass)
      }
      if (rclass %in% c("tibble", "data.frame")) {
        out <- sov2tbl(res = res, rclass = rclass, variable = TRUE)
      }
      class(out) <- c(class(out), "ba_observationvariables_search")
      return(out)
    })
}
