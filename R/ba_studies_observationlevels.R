#' ba_studies_observationlevels
#'
#' Call to retrieve the list of supported observation levels.
#'
#' @param con brapi connection object
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character; default is 'tibble'
#'
#' @details Observation levels indicate the granularity level at which the measurements
#' are taken. The values are used to supply the observationLevel parameter in
#' the observation unit details call.
#'
#' @return An object of class as defined by rclass containing the details of the
#'         measured observation variables for a requested study.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#'
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/ObservationLevels_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_observationlevels.R
#' @export
ba_studies_observationlevels <- function(con = NULL,
                                         pageSize = 1000,
                                         page = 0,
                                         rclass = c("tibble", "data.frame", "list", "vector", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "observationlevels")
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("observationlevels")
  callurl <- get_endpoint(pointbase = brp, pageSize = pageSize, page = page)

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_studies_observationlevels")
    show_metadata(res)
    return(out)
  })
}
