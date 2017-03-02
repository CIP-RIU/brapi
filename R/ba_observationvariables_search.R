#' ba_observationvariables_search
#'
#' lists the breeding observationvariables
#'
#'
#' @param con brapi connection object
#' @param observationVariableDbIds  vector of string; default: any
#' @param ontologyXrefs  vector of string; default: any
#' @param ontologyDbIds  vector of string; default: any
#' @param methodDbIds  vector of string; default: any
#' @param scaleDbIds  vector of string; default: any
#' @param names  vector of string; default: any
#' @param datatypes  vector of string; default: any
#' @param traitClasses vector of string; default: any
#' @param rclass string; default: tibble
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @example inst/examples/ex-ba_observationvariables_search.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableSearch.md}{github}
#' @family brapicore
#' @export
ba_observationvariables_search <- function(
  con = NULL,
  observationVariableDbIds = "any",
  ontologyXrefs = "any",
  ontologyDbIds = "any",
  methodDbIds = "any",
  scaleDbIds = "any",
  names = "any",
  datatypes = "any",
  traitClasses = "any",
  rclass = "tibble") {

  ba_check(con, FALSE, "variables-search")
  stopifnot(is.character(observationVariableDbIds))
  stopifnot(is.character(ontologyXrefs))
  stopifnot(is.character(ontologyDbIds))
  stopifnot(is.character(methodDbIds))
  stopifnot(is.character(scaleDbIds))
  stopifnot(is.character(names))
  stopifnot(is.character(datatypes))
  stopifnot(is.character(traitClasses))
  check_rclass(rclass)

  brp <- get_brapi(con)

  pvariables <- paste0(brp, "variables-search/")

  try({
    body <- list(observationVariableDbIds = observationVariableDbIds %>% as.list(),
                 ontologyXrefs = ontologyXrefs,
                 ontologyXrefs = ontologyXrefs,
                 ontologyXrefs = ontologyXrefs,
                 scaleDbIds = scaleDbIds,
                 names = names,
                 datatypes = datatypes,
                 traitClasses = traitClasses
                 )
    res <- brapiPOST(pvariables, body, con = con)
    res <- httr::content(res, "text", encoding = "UTF-8")

    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res, rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- sov2tbl(res, rclass, TRUE)
    }
    class(out) <- c(class(out), "ba_observationvariables_search")
    return(out)
  })
}
