
#' marker search
#'
#' Lists markers as result of a search.
#'
#' @param markerDbId integer; marker id; default: 0
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{http://docs.brapi.apiary.io/#reference/0/markers}
#'
#' @return data.frame
#' @family brapi_call
#' @family genotyping
#' @export
markers <- function(markerDbId = 0,
                             rclass = "tibble"){
  brapi::check(FALSE)
  brp <- get_brapi()
  markers = paste0(brp, "markers/", markerDbId )

  try({
    res <- brapiGET(markers)
    res <- httr::content(res, "text", encoding = "UTF-8")
     dat2tbl(res, rclass)
  })
}

