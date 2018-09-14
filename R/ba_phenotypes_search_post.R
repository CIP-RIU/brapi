#' ba_phenotypes_search_post
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
#' @example inst/examples/ex-ba_phenotypes_search_post.R
#'
#' @import httr
#' @export
ba_phenotypes_search_post <- function(con = NULL,
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
    resp <- brapiPOST(url = callurl, body = body, con = con)
    show_metadata(resp)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")

    out <- NULL
    if (rclass != "json") {
      out <- baps2rclass(cont, rclass)
    } else {
      out <- cont
    }

    class(out) <- c(class(out), "ba_phenotypes_search_post")

    return(out)
  })
}
