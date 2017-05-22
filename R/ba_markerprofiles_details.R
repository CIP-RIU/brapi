#' ba_markerprofiles_details
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param markerprofilesDbId character; default 0
#' @param expandHomozygotes logical; default false
#' @param unknownString chaaracter; default: '-'
#' @param sepPhased character; default: '|'
#' @param sepUnphased character; default: '/'
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/MarkerProfiles/MarkerProfileData.md}{github}
#'
#' @return data.frame
#' @example inst/examples/ex-ba_markerprofiles_details.R
#' @family markerprofiles
#' @family genotyping
#' @export
ba_markerprofiles_details <- function(con = NULL,
                                      markerprofilesDbId = "",
                                      expandHomozygotes = FALSE,
                                      unknownString = "N",
                                      sepPhased = "|",
                                      sepUnphased = "/",
                                      page = 0,
                                      pageSize = 10000,
                                      rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "markerprofiles/id/")
  stopifnot(is.character(markerprofilesDbId))
  stopifnot(is.logical(expandHomozygotes))
  stopifnot(is.character(sepPhased))
  stopifnot(is.character(sepUnphased))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(brapi = con)
  markerprofiles_alleles <- paste0(brp, "markerprofiles/", markerprofilesDbId, "/?")
  expandHomozygotes <- ifelse(expandHomozygotes != "", paste0("expandHomozygotes=", expandHomozygotes, "&"), "")
  sepPhased <- ifelse(sepPhased != "", paste0("sepPhased=", sepPhased, "&"), "")
  sepUnphased <- ifelse(sepUnphased != "", paste0("sepUnphased=", sepUnphased, "&"), "")
  page <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
  pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  rclass <- ifelse(rclass %in% c("tibble", "data.frame", "json", "list"), rclass, "tibble")
  markerprofiles_alleles <- paste0(markerprofiles_alleles,
                                   expandHomozygotes,
                                   sepPhased,
                                   sepUnphased,
                                   pageSize,
                                   page)
  try({
    res <- brapiGET(url = markerprofiles_alleles, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res, rclass = rclass, brapi_class = "brapi_markerprofiles_alleles")
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- mpa2tbl(res = res, rclass = rclass)
    }
    class(out) <- c(class(out), "ba_markerprofiles_details")
    return(out)
  })
}
