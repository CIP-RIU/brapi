#' observationLevels
#'
#' lists crops available in a database
#'
#' @param rclass character; default is FALSE; whether to display the raw list object or not
#' @author Reinhard Simon
#' @return a vector of crop names or NULL
#' @family brapi_call
#' @family phenotyping
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Studies/ListObservationLevels.md}
#' @export
observationLevels <- function(rclass = "vector"){
  brapi::check(FALSE, "observationLevels")
  observationLevels_List = paste0(get_brapi(), "observationLevels")
  try({
    res <- brapiGET(observationLevels_List)
    res <- httr::content(res, "text",encoding = "UTF-8")
    out <- dat2tbl(res, rclass)
    class(out) = c(class(out), "brapi_observationLevels")
    out
  })
}
