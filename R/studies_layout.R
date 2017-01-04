#' studies_layout
#'
#' lists studies_layout available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param studyDbId string; default: 1
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/studies_layout/Liststudies_layout.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family phenotyping
#' @export
studies_layout <- function(studyDbId = 1, rclass = "tibble") {
  brapi::check(FALSE, "studies/id/layout")
  brp <- get_brapi()
  studies_layout_list = paste0(brp, "studies/", studyDbId, "/layout/")

  try({
    res <- brapiGET(studies_layout_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    if (rclass %in% c("json", "list")) {
      out = dat2tbl(res, rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out = lyt2tbl(res, rclass)
    }
    class(out) = c(class(out), "brapi_studies_layout")
    out
  })
}
