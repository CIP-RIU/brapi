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
                                    rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id/observations")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != "")
  stopifnot(is.character(observationVariableDbIds))
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  endpoint <- paste0(brp, "studies/", studyDbId, "/observations?")
  pobservationVariableDbIds <- ifelse(all(observationVariableDbIds == ""),
                                      "",
                                      paste0("observationVariableDbIds=",
                                             sub(pattern = ",$",
                                             replacement = "",
                                             x = paste0(observationVariableDbIds,
                                                        sep = ",",
                                                        collapse = "")),
                                             "&"))
  ppages <- get_ppages(pageSize, page)
  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = paste0(endpoint,
                            pobservationVariableDbIds,
                            ppages$pageSize,
                            ppages$page))
  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list", "tibble", "data.frame")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_observations")
    show_metadata(res)
    return(out)
  })
}
