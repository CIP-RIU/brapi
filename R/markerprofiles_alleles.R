
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
markerprofiles_alleles <- function(markerprofilesDbId = 0,
                             expandHomozygotes = FALSE,
                             unknownString  = "-",
                             sepPhased = "|",
                             sepUnphased = "/",
                             page = 0, pageSize = 10000,
                             rclass = "list"){
  brapi::check(FALSE)
  brp <- get_brapi()
  if(markerprofilesDbId > 0) markerprofiles_alleles = paste0(brp, "markerprofiles/", markerprofilesDbId)
  if (is.numeric(page) & is.numeric(pageSize)) {
    markerprofiles_alleles = paste0(markerprofiles_alleles, "/?page=", page, "&pageSize=", pageSize)
  }

  markerprofiles_alleles = paste0(markerprofiles_alleles, "&expandHomozygtes=", expandHomozygotes)
  markerprofiles_alleles = paste0(markerprofiles_alleles, "&unknownString=", unknownString)
  markerprofiles_alleles = paste0(markerprofiles_alleles, "&sepPhased=", sepPhased)
  markerprofiles_alleles = paste0(markerprofiles_alleles, "&sepUnphased=", sepUnphased)

  tryCatch({
    res <- brapiGET(markerprofiles_alleles)
    res <- httr::content(res, "text", encoding = "UTF-8")
    dat2tbl(res, rclass)
  }, error = function(e){
    NULL
  })
}

