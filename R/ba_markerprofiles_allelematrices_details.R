#' ba_markerprofiles_allelematrices_details
#'
#' Retrieve available allelematrices details for a specific study.
#'
#' @param con list, brapi connection object
#' @param studyDbId character, the internal database identifier for a study of
#'                  which the available allelematrices details are to be
#'                  retrieved e.g. "1001"; \strong{REQUIRED ARGUMENT} with
#'                  default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "data.frame"/"list"/"json"
#'
#' @note The handling of long-running responses via asynch status messages
#'       not yet implemented.
#' @note Tested against: test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @return An object of class as defined by rclass containing the allelematrices
#'         details of the requested study internal database indentifier.
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/MarkerProfiles/AlleleMatrices_GET.md}{github}
#'
#' @family markerprofiles
#' @family genotyping
#'
#' @example inst/examples/ex-ba_markerprofiles_allelematrices_details.R
#'
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @export
ba_markerprofiles_allelematrices_details <- function(con = NULL,
                                                     studyDbId = "",
                                                     pageSize = 10000,
                                                     page = 0,
                                                     rclass = c("tibble",
                                                                "data.frame",
                                                                "list",
                                                                "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(studyDbId)
  check_req(studyDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("allelematrices")
  callurl <- get_endpoint(pointbase = brp,
                          studyDbId = studyDbId,
                          pageSize = pageSize,
                          page = page)

  out <- try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    # show_metadata(resp)
    dat2tbl(res = cont , rclass = rclass, result_level = "data")
  })

  class(out) <- c(class(out), "ba_markerprofiles_allelematrices_details")
  # show_metadata(resp)
  return(out)
}
