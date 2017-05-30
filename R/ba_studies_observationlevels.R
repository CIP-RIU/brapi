#' ba_studies_observationlevels
#'
#' Call to retrieve the list of supported observation levels.
#'
#' Observation levels indicate the granularity level at which the measurements
#' are taken. The values are used to supply the observationLevel parameter in
#' the observation unit details call.
#'
#' @param con brapi connection object
#' @param rclass character; default is FALSE; whether to display the raw list object or not
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
#' @example inst/examples/ex-ba_studies_observationlevels.R
#' @family studies
#' @family phenotyping
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListObservationLevels.md}{github}
#' @export
ba_studies_observationlevels <- function(con = NULL,
                                         rclass = "vector") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "observationLevels")
  check_rclass(rclass = rclass)
  observationLevels_List <- paste0(get_brapi(brapi = con), "observationLevels")
  try({
    res <- brapiGET(url = observationLevels_List, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    class(out) <- c(class(out), "ba_studies_observationlevels")
    return(out)
  })
}
