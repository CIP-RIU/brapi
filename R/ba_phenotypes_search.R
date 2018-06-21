#' ba_phenotypes_search
#'
#' lists the breeding observationvariables
#'
#'
#' @param con brapi list, connection object
#' @param germplasmDbIds  vector of character; default: ''
#' @param observationVariableDbIds  vector of character; default: ''
#' @param studyDbIds  vector of character; default: ''
#' @param locationDbIds  vector of character; default: ''
#' @param programDbIds  vector of character; default: ''
#' @param seasonDbIds  vector of character; default: ''
#' @param observationLevel  vector of character; default: ''
#' @param pageSize integer default: 100
#' @param page integer default: 0
#' @param rclass character; default: tibble
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @example inst/examples/ex-ba_phenotypes_search.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Phenotypes/PhenotypeSearch.md}{github}
#' @family brapicore
#' @export
ba_phenotypes_search <- function(con = NULL,
                                 germplasmDbIds = "",
                                 observationVariableDbIds = "",
                                 studyDbIds = "",
                                 locationDbIds = "",
                                 programDbIds = "",
                                 seasonDbIds = "",
                                 observationLevel = "",
                                 pageSize = 100,
                                 page = 0,
                                 rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "phenotypes-search")
  stopifnot(is.character(germplasmDbIds))
  stopifnot(is.character(observationVariableDbIds))
  stopifnot(is.character(studyDbIds))
  stopifnot(is.character(locationDbIds))
  stopifnot(is.character(programDbIds))
  stopifnot(is.character(seasonDbIds))
  stopifnot(is.character(observationLevel))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  pvariables <- paste0(brp, "phenotypes-search/")


  try({
    body <- list(germplasmDbId = germplasmDbIds,
                 observationVariableDbId = observationVariableDbIds,
                 studyDbId = studyDbIds,
                 locationDbId = locationDbIds,
                 programDbId = programDbIds,
                 seasonDbId = seasonDbIds,
                 observationLevel = observationLevel,
                 pageSize = pageSize,
                 page = page)
    res <- brapiPOST(url = pvariables, body = body, con = con)
    show_metadata(res)

    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    if(rclass != "json") {
      out <- baps2rclass(res2, rclass)
    } else {
      out <- res2
    }

    class(out) <- c(class(out), "ba_phenotypes_search")

    return(out)
  })
}
