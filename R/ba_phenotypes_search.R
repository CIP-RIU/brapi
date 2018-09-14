#' ba_phenotypes_search
#'
#' Retrieve a list of observation units with the observed Phenotypes using a GET
#' method.
#'
#' @param con list, brapi connection object
#' @param germplasmDbId character, search for observation units where the
#'                      specified germplasm has been used/tested; e.g. "CML123";
#'                      default: ""
#' @param observationVariableDbId character, search for observation units where
#'                                the specified observation variable, supplied as
#'                                a character string of the internal observation
#'                                variable database identifier e.g. "CO-PH-123",
#'                                has been measured; default: ""
#' @param studyDbId character, search for observation units by an internal study
#'                  database identifier e.g. "1001"; default: ""
#' @param locationDbId character, search for observation units with the observed
#'                    Phenotypes by an internal location database identifier;
#'                    default: ""
#' @param trialDbId character, search for observation units with the observed
#'                  Phenotypes by an internal trial database identifier;
#'                  default: ""
#' @param programDbId character, search for observation units with the observed
#'                    Phenotypes by an internal program database identifier;
#'                    default: ""
#' @param seasonDbId  character, search for observation units with the observed
#'                    Phenotypes by an internal season database identifier;
#'                    default: ""
#' @param observationLevel character, search for observation units with the
#'                         observed Phenotypes by specifying observation level
#'                         e.g. "plant"/"plot"; default: ""
#' @param observationTimeStampRangeStart chararcter, specifying the time stamp
#'                                       range start from which to search for the
#'                                       observation units with the observed
#'                                       Phenotypes; default: ""
#' @param observationTimeStampRangeEnd character, specifying the time stamp range
#'                                     end to which to search for the observation
#'                                     units with the observed Phenotypes;
#'                                     default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the observation
#'         units with the observed Phenotypes.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Phenotypes/PhenotypesSearch_GET.md}{github}
#'
#' @family studies
#' @family phenotyping
#' @import tibble
#' @export
### to be put in front of @import #' @example inst/examples/ex-ba_studies_search.R
ba_phenotypes_search <- function(con = NULL,
                                 germplasmDbId = "",
                                 observationVariableDbId = "",
                                 studyDbId = "",
                                 locationDbId = "",
                                 trialDbId = "",
                                 programDbId = "",
                                 seasonDbId = "",
                                 observationLevel = "",
                                 observationTimeStampRangeStart = "",
                                 observationTimeStampRangeEnd = "",
                                 pageSize = 1000,
                                 page = 0,
                                 rclass = c("tibble", "data.frame",
                                            "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "phenotypes-search-get")
  check_character(germplasmDbId, observationVariableDbId, studyDbId,
                  locationDbId, trialDbId, programDbId, seasonDbId,
                  observationLevel, observationTimeStampRangeStart,
                  observationTimeStampRangeEnd)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con) %>% paste0("phenotypes-search")
  callurl <- get_endpoint(brp,
                          germplasmDbId = germplasmDbId,
                          observationVariableDbId = observationVariableDbId,
                          studyDbId = studyDbId,
                          locationDbId = locationDbId,
                          trialDbId = trialDbId,
                          programDbId = programDbId,
                          seasonDbId = seasonDbId,
                          observationLevel = observationLevel,
                          observationTimeStampRangeStart = observationTimeStampRangeStart,
                          observationTimeStampRangeEnd = observationTimeStampRangeEnd,
                          page = page,
                          pageSize = pageSize)

  out <- NULL
  out <- try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")

    if (rclass != "json") {
      out <- baps2rclass(cont, rclass)
    } else {
      out <- cont
    }
    out
  })

  if (!is.null(out)) {
    class(out) <- c(class(out), "ba_phenotypes_search_get")
  } else {
    message("Server did not return a result!
            Check your query parameters or contact the server administrator.")
  }
  show_metadata(resp)
  return(out)
  }
