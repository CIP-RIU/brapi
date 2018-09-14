#' ba_studies_observations
#'
#' Retrieve all observations of a specific study, where there are measurements
#' for the given observation variables.
#'
#' @param con list, brapi connection object
#' @param studyDbId character, the internal database identifier for a study of
#'                  which the observation measurements for the given observation
#'                  variables are to be retrieved e.g. "1001";
#'                  \strong{REQUIRED ARGUMENT} with default: ""
#' @param observationVariableDbIds character vector; Set of observation variable
#'                                 DbIds (combination of trait, unit and method),
#'                                 supplied as a comma separated character vector
#'                                 of internal observation variable identifiers
#'                                 e.g. c("393939","393938"), of which the
#'                                 observation measurements for the specified
#'                                 studyDbId are retrieved; default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @details This call must have set a specific identifier. The default is an empty
#'          string. If not changed to an identifier present in the database this
#'          will result in an error.
#'
#' @return An object of class as defined by rclass containing the observation
#'         measurements of the supplied observation variabble DbIds for a
#'         requested study.
#'
#' @note Tested against: test-server, sweetpotatobase
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Studies_Observations_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_observations.R
#' @import tibble
#' @export
ba_studies_observations <- function(con = NULL,
                                    studyDbId = "",
                                    observationVariableDbIds = "",
                                    pageSize = 1000,
                                    page = 0,
                                    rclass = c("tibble", "data.frame",
                                               "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/observations")
  check_req(studyDbId)
  check_character(studyDbId, observationVariableDbIds)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con) %>% paste0("studies/", studyDbId, "/observations")
  callurl <- get_endpoint(brp,
                          observationVariableDbIds = observationVariableDbIds,
                          pageSize = pageSize,
                          page = page
  )
  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list", "tibble", "data.frame")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_observations")
    show_metadata(resp)
    return(out)
  })
}
