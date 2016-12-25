
#' marker search
#'
#' Lists markers as result of a search.
#'
#' @param markerprofilesDbId integer; default 0
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
#' @references \url{http://docs.brapi.apiary.io/#reference/0/markerprofiles_alleles}
#'
#' @return data.frame
#' @family brapi_call
#' @family genotyping
#' @export
markerprofiles_alleles <- function(markerprofilesDbId = "",
                             expandHomozygotes = FALSE,
                             unknownString  = "N",
                             sepPhased = "|",
                             sepUnphased = "/",
                             page = 0, pageSize = 10000,
                             rclass = "tibble"){
  brapi::check(FALSE)
  brp <- get_brapi()
  markerprofiles_alleles = paste0(brp, "markerprofiles/", markerprofilesDbId, "/?")

  expandHomozygotes = ifelse(expandHomozygotes != "", paste0("expandHomozygotes=", expandHomozygotes, "&"), "")
  sepPhased = ifelse(sepPhased != "", paste0("sepPhased=", sepPhased, "&"), "")
  sepUnphased = ifelse(sepUnphased != "", paste0("sepUnphased=", sepUnphased, "&"), "")

  page = ifelse(is.numeric(page), paste0("page=", page, ""), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  rclass = ifelse(rclass %in% c("tibble", "data.frame", "json", "list"), rclass, "tibble")

  markerprofiles_alleles = paste0(markerprofiles_alleles, expandHomozygotes, sepPhased, sepUnphased,
                          pageSize, page)



  try({
    res <- brapiGET(markerprofiles_alleles)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    if(rclass %in% c("json", "list")) out <- dat2tbl(res, rclass, "brapi_markerprofiles_alleles")
    if(rclass %in% c("data.frame", "tibble")) out <- mpa2tbl(res, rclass)
    out
  })
}

