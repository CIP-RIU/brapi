#' ba_studies_details
#'
#' Gets study details given an internal database identifier.
#'
#' @param con list, brapi connection object
#' @param studyDbId character, the internal database identifier for a study of
#'                  which the study details are to be retrieved e.g. "1001";
#'                  \strong{REQUIRED ARGUMENT} with default: ""
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @details This function must have set a specific study identifier. The default
#'          is an empty string. If not changed to an study identifier present in
#'          the database this will result in an error.
#'
#' @return An object of class as defined by rclass containing the study details.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Studies_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_details.R
#' @import dplyr
#' @export
ba_studies_details <- function(con = NULL,
                               studyDbId = "",
                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studies/id")
  stopifnot(is.character(studyDbId))
  stopifnot(studyDbId != "")
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  studies <- paste0(brp, "studies/", studyDbId)
  try({
    res <- brapiGET(url = studies, con = con)
    out <- NULL
    if (is.ba_status_ok(resp = res)) {
      res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
      if (rclass %in% c("json", "list")) {
        out <- dat2tbl(res = res2, rclass = rclass)
      }
      if (rclass %in% c("data.frame", "tibble")) {
        out <- stdd2tbl(res = res2, rclass = rclass)
      }
      class(out) <- c(class(out), "ba_studies_details")
    }
    show_metadata(res)
    return(out)
  })
}
