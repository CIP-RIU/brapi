#' ba_observationvariables_search
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
#' @example inst/examples/ex-ba_observationvariables_search.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/ObservationVariables/VariableSearch.md}{github}
#' @family brapicore
#' @export
ba_observationvariables_search <- function(con = NULL,
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

    check_paging(pageSize, page)
    check_rclass(rclass = rclass)
    brp <- get_brapi(con = con)
    pvariables <- paste0(brp, "variables-search/")

    try({
      #res <- brapiPOST(pvariables, body, con = con)
      body <- list(observationVariableDbIds =
                     ifelse(observationVariableDbIds != '',
                     observationVariableDbIds %>%
                     as.list(),
                     ''),
                   ontologyXrefs =
                     ifelse(ontologyXrefs != '',
                            ontologyXrefs %>%
                              as.list(),
                            ''),
                   scaleDbIds =
                     ifelse(scaleDbIds != '',
                            scaleDbIds %>%
                              as.list(),
                            ''),
                   names =
                     ifelse(names != '',
                            names %>%
                              as.list(),
                            ''),
                   datatypes =
                     ifelse(datatypes != '',
                            datatypes %>%
                              as.list(),
                            ''),
                   traitClasses =
                     ifelse(traitClasses != '',
                            traitClasses %>%
                              as.list(),
                            ''),
                   pageSize =
                     ifelse(pageSize != '',
                            pageSize %>%
                              as.integer(),
                            ''),
                   page =
                     ifelse(page != '',
                            page %>%
                              as.integer(),
                            '')
      )
      for (i in length(body):1) {
        if(body[[i]] == '') {
          body[[i]] <- NULL
        }
      }
      message("Query params:")
      message(str(body))
      res <- brapiPOST(url = pvariables, body = body, con = con)
      res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
      out <- NULL
      if (rclass %in% c("json", "list")) {
        out <- dat2tbl(res = res2, rclass = rclass)
      }
      if (rclass %in% c("tibble", "data.frame")) {
        out <- sov2tbl(res = res2, rclass = rclass, variable = TRUE)
      }
      class(out) <- c(class(out), "ba_observationvariables_search")
      show_metadata(res)
      return(out)
    })
}
