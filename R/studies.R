#' studies
#'
#' Gets studies details given an id.
#'
#' @param rclass character; tibble
#' @param studiesDbId string; default 0; an internal ID for a studies
#' @import tidyjson
#' @import dplyr
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/studies-details-by-studiesdbid}
#' @return list
#' @family brapi_call
#' @family core
#' @family studies
#' @export
studies <- function(studiesDbId = 0, rclass = "tibble") {
  brapi::check(FALSE, "studies/id")
  studies = paste0(get_brapi(), "studies/", studiesDbId, "/")

  try({
    res <- brapiGET(studies)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out <- NULL

    if (rclass %in% c("json", "list")) out <- dat2tbl(res, rclass)
    if (rclass %in% c("data.frame", "tibble")) out  <- stdd2tbl(res, rclass)
    out
  })
}
