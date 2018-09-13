#' ba_phenotypes_search
#'
#' lists the breeding observationvariables
#'
#' @param con brapi list, connection object
#' @param germplasmDbIds  vector of character; default: ''
#' @param observationVariableDbIds  vector of character; default: ''
#' @param studyDbIds  vector of character; default: ''
#' @param locationDbIds  vector of character; default: ''
#' @param trialDbIds vector of character; default: ''
#' @param programDbIds  vector of character; default: ''
#' @param seasonDbIds  vector of character; default: ''
#' @param observationLevel  character; default: ''
#' @param observationTimeStampRangeStart character; default: ''
#' @param observationTimeStampRangeEnd character; default: ''
#' @param pageSize integer default: 1000
#' @param page integer default: 0
#' @param rclass character; default: tibble
#'
#' @return rclass
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Phenotypes/PhenotypesSearch_GET.md}{github}
#'
#' @family brapicore
#'
#' @example inst/examples/ex-ba_phenotypes_search.R
#'
#' @import httr
#' @export
ba_phenotypes_search <- function(con = NULL,
                                 germplasmDbIds = "",
                                 observationVariableDbIds = "",
                                 studyDbIds = "",
                                 locationDbIds = "",
                                 trialDbIds = "",
                                 programDbIds = "",
                                 seasonDbIds = "",
                                 observationLevel = "",
                                 observationTimeStampRangeStart = "",
                                 observationTimeStampRangeEnd = "",
                                 pageSize = 1000,
                                 page = 0,
                                 rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "phenotypes-search")
  check_character(germplasmDbIds,
                  observationVariableDbIds,
                  studyDbIds,
                  locationDbIds,
                  trialDbIds,
                  programDbIds,
                  seasonDbIds,
                  observationLevel,
                  observationTimeStampRangeStart,
                  observationTimeStampRangeEnd)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con)
  callurl <- paste0(brp, "phenotypes-search")

  try({
    body <- get_body(germplasmDbIds = germplasmDbIds,
                     observationVariableDbIds = observationVariableDbIds,
                     studyDbIds = studyDbIds,
                     locationDbIds = locationDbIds,
                     trialDbIds = trialDbIds,
                     programDbIds = programDbIds,
                     seasonDbIds = seasonDbIds,
                     observationLevel = observationLevel,
                     observationTimeStampRangeStart = observationTimeStampRangeStart,
                     observationTimeStampRangeEnd = observationTimeStampRangeEnd)
    res <- brapiPOST(url = callurl, body = body, con = con)
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
