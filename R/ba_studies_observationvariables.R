#' ba_studies_observationVariables
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
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @details This call must have set a specific identifier. The default is an
#'          empty string. If not changed to an identifier present in the
#'          database this will result in an error.
#'
#' @return An object of class as defined by rclass containing the details of the
#'         measured observation variables for a requested study.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: deprecated
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Studies_ObservationVariables_GET_Deprecated.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_observationVariables.R
#' @import tibble
#' @export
ba_studies_observationVariables <- function(con = NULL,
                                            studyDbId = "",
                                            pageSize = 1000,
                                            page = 0,
                                            rclass = "tibble") {
  .Deprecated(new = "ba_studies_observationvariables")
  ba_check(con = con, verbose = FALSE, brapi_calls =
             "studies/id/observationVariables")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != "")
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  studies_observationVariables_list <- paste0(brp, "studies/", studyDbId, "/observationVariables?")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                   pageSize, "&"), "")
  ppage <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  if (page == 0 & pageSize == 1000) {
    ppage <- ""
    ppageSize <- ""
  }
  # modify brapi call url to include pagenation
  callurl <- sub(pattern = "[/?&]$",
                 replacement = "",
                 x = paste0(studies_observationVariables_list,
                            ppageSize,
                            ppage))
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
