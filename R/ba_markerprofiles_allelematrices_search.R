#' ba_markerprofiles_allelematrices_search
#'
#' Gets markers in matrix format. If the format parameter is set to either csv or tsv the returned object
#' is always a tibble object. If the format parameter is 'json' (default) the rclass parameter can be used
#' to as in other functions.
#'
#' @param con brapi connection object
#' @param markerProfileDbId character vector; default ''
#' @param markerDbId character vector; default ''
#' @param matrixDbId character vector; default ''
#' @param format character; default: json; other: csv, tsv
#' @param expandHomozygotes logical; default false
#' @param unknownString chaaracter; default: '-'
#' @param sepPhased character; default: ''
#' @param sepUnphased character; default: ''
#' @param pageSize integer; default 1000
#' @param page integer; default: 0
#' @param rclass character; default: tibble
#'
#' @note The handling of long-running responses via asynch status messages is not yet implemented.
#'
#' @return rclass as requested
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/MarkerProfiles/AlleleMatricesSearch_GET.md}{github}
#'
#' @family markerprofiles
#' @family genotyping
#'
#' @example inst/examples/ex-ba_markerprofiles_allelematrices_search.R
#'
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @export
ba_markerprofiles_allelematrices_search <- function(con = NULL,
                                                  markerProfileDbId = "",
                                                  markerDbId = "",
                                                  matrixDbId = "",
                                                  format = "json",
                                                  expandHomozygotes = FALSE,
                                                  unknownString = "-",
                                                  sepPhased = "",
                                                  sepUnphased = "",
                                                  pageSize = 1000,
                                                  page = 0,
                                                  rclass = c("tibble", "data.frame",
                                                             "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(markerProfileDbId, markerDbId, markerDbId, matrixDbId, format,
                  unknownString, sepPhased, sepUnphased)
  stopifnot(is.logical(expandHomozygotes))
  check_req_any(markerProfileDbId = markerProfileDbId,
                markerDbId = markerDbId,
                matrixDbId = matrixDbId)
  rclass <- match_req(rclass)
  brp <- get_brapi(con = con) %>% paste0("allelematrices-search")
  callurl <- get_endpoint(brp,
                          markerProfileDbId = markerProfileDbId,
                          markerDbId = markerDbId,
                          matrixDbId = matrixDbId,
                          format = format,
                          expandHomozygotes = expandHomozygotes,
                          unknownString = unknownString,
                          sepPhased = sepPhased,
                          sepUnphased = sepUnphased,
                          pageSize = pageSize,
                          page = page
  )

  out <- try({
    res <- brapiGET(url = callurl, con = con)
    ams2tbl(res = res, format = format, rclass = rclass)
  })

  class(out) <- c(class(out), "ba_markerprofiles_allelematrices_search")
  show_metadata(res)
  return(out)
}
