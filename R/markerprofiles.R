
#' marker search
#'
#' Lists markers as result of a search.
#'
#' @param germplasmDbId integer; default 0
#' @param studyDbId integer; default 0
#' @param sampleDbId integer; default: 0
#' @param extractDbId integer; default: 0
#' @param methodDbId string; default: unknown
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{http://docs.brapi.apiary.io/#reference/0/markerprofiles}
#'
#' @return data.frame
#' @family brapi_call
#' @family genotyping
#' @export
markerprofiles <- function(germplasmDbId = 0,
                             studyDbId = 0,
                             sampleDbId  = 0,
                             extractDbId = 0,
                             methodDbId = 0,
                             page = 0, pageSize = 10000,
                             rclass = "tibble"){
  brapi::check(FALSE, "markerprofiles")
  brp <- get_brapi()
  if (is.numeric(page) & is.numeric(pageSize)) {
    markerprofiles = paste0(brp, "markerprofiles/?page=", page, "&pageSize=", pageSize)
  }
  if(germplasmDbId > 0) markerprofiles = paste0(markerprofiles, "&germplasm=", germplasmDbId)
  if(studyDbId > 0) markerprofiles = paste0(markerprofiles, "&studyDbId=", studyDbId)
  if(sampleDbId > 0) markerprofiles = paste0(markerprofiles, "&sample=", sampleDbId)
  if(extractDbId > 0) markerprofiles = paste0(markerprofiles, "&extract=", extractDbId)
  if(methodDbId > 0) markerprofiles = paste0(markerprofiles, "&method=", methodDbId)

  tryCatch({
    res <- brapiGET(markerprofiles)
    res <- httr::content(res, "text", encoding = "UTF-8")
    dat2tbl(res, rclass)
  }, error = function(e){
    NULL
  })
}

