#' ba_markerprofiles_allelematrices_details
#'
#'This resource is used for reading and writing genomic matrices
#'
#' @param con brapi connection object
#' @param studyDbId character, \strong{REQUIRED ARGUMENT} with default: ""
#' @param pageSize integer; default 1000
#' @param page integer; default: 0
#' @param rclass character; default: tibble
#'
#' @note The handling of long-running responses via asynch status messages is not yet implemented.
#'
#' @return rclass as requested
#'
#' @author Reinhard Simon
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
                                                  rclass = c("tibble", "data.frame",
                                                             "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(studyDbId)
  check_req(studyDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("allelematrices")
  callurl <- get_endpoint(brp,
                          studyDbId = studyDbId,
                          pageSize = pageSize,
                          page = page
                          )
  out <- try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    # Bshow_metadata(res)
    dat2tbl(res = res2 , rclass = rclass, result_level = "data")
  })

  class(out) <- c(class(out), "ba_markerprofiles_allelematrices_details")

  return(out)
}
