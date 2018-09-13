#' ba_studies_observationvariables
#'
#' Retrieve details of observation variables measured in a specific study.
#'
#' @param con list, brapi connection object
#' @param studyDbId character, the internal database identifier for a study of
#'                  which the details of measured observation variables are to
#'                  be retrieved e.g. "1001"; \strong{REQUIRED ARGUMENT} with
#'                  default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @details This call must have set a specific identifier. The default is an
#'          empty string. If not changed to an identifier present in the
#'          database this will result in an error.
#'
#' @return An object of class as defined by rclass containing the details of the
#'         measured observation variables for a requested study.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Studies_ObservationVariables_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_observationvariables.R
#' @import tibble
#' @export
ba_studies_observationvariables <- function(con = NULL,
                                            studyDbId = "",
                                            pageSize = 1000,
                                            page = 0,
                                            rclass = c("tibble", "data.frame",
                                                       "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls =
             "studies/id/observationvariables")
  check_req(studyDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("studies/", studyDbId, "/observationvariables")
  callurl <- get_endpoint(brp, pageSize = pageSize, page = page)

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- sov2tbl(res = res2, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_studies_observationvariables")
    show_metadata(res)
    return(out)
  })
}
