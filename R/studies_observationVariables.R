#' studies_observationVariables
#'
#' lists studies_observationVariables available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param studyDbId character; default: 1
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/studies_observationVariables/Liststudies_observationVariables.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family phenotyping
#' @export
studies_observationVariables <- function(studyDbId = 1,
                                 rclass = "tibble") {
  brapi::check(FALSE, "studies/id/observationVariables")
  brp <- get_brapi()
  studies_observationVariables_list = paste0(brp, "studies/", studyDbId ,"/observationVariables/?")

  try({
    res <- brapiGET(studies_observationVariables_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    if (rclass %in% c("json", "list")) {
      out = dat2tbl(res, rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out = sov2tbl(res, rclass)
    }
    class(out) = c(class(out), "brapi_studies_observationVariables")
    out
  })
}
