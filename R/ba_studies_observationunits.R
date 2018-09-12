#' ba_studies_observationunits
#'
#' Retrieve all the observation units within a specific study.
#'
#' @param con list, brapi connection object
#' @param studyDbId character, the internal database identifier for a study of
#'                  which the observation units are to be retrieved e.g. "1001";
#'                  \strong{REQUIRED ARGUMENT} with default: ""
#' @param observationLevel character, specifying the granularity level of
#'                         observation units, where either "plotNumber" or
#'                         "plantNumber" fields will be relavant depending on
#'                         whether granularity is specified as "plot" or "plant"
#'                         respectively; default: "any", other possible value:
#'                         "plot"/"plant"
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @details This call must have set a specific identifier. The default is an empty
#'          string. If not changed to an identifier present in the database this
#'          will result in an error.
#'
#' @return An object of class as defined by rclass containing the observation
#'         units for a requested study.
#'
#' @note Tested against: test-server, sweetpotatobase
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#' @note R Brapi Status: incomplete response parsing
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Studies_ObservationUnits_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_observationunits.R
#' @import tibble
#' @export
ba_studies_observationunits <- function(con = NULL,
                                        studyDbId = "",
                                        observationLevel = c("any", "plot", "plant"),
                                        pageSize = 1000,
                                        page = 0,
                                        rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls =
             "studies/id/observationunits")
  studyDbId <- match_req(studyDbId)
  observationLevel <- match.arg(observationLevel)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con)
  endpoint <- paste0(brp, "studies/", studyDbId, "/observationunits?")
  pobservationLevel <- switch(observationLevel,
                              "any"   = "",
                              "plot"  = "observationLevel=plot&",
                              "plant" = "observationLevel=plant&")
  ppages <- get_ppages(pageSize, page)
  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = paste0(endpoint,
                            pobservationLevel,
                            ppages$pageSize,
                            ppages$page))

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- sou2tbl(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_observationunits")
    show_metadata(res)
    return(out)
  })
}
