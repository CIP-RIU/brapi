#' germplasm
#'
#' Gets germplasm details given an id.
#'
#' @param rclass character; tibble
#' @param germplasmDbId string; default 0; an internal ID for a germplasm
#' @import tidyjson
#' @import dplyr
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/germplasm-details-by-germplasmdbid}
#' @return list
#' @export
germplasm <- function(germplasmDbId = 0, rclass = "tibble") {
  brapi::check(FALSE)
  germplasm = paste0(get_brapi(), "germplasm/", germplasmDbId, "/")

  tryCatch({
    res <- brapiGET(germplasm)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out <- NULL

    if (rclass %in% c("json", "list")) out <- dat2tbl(res, rclass)
    if (rclass == "data.frame") out  <- gp2tbl(res)
    if (rclass == "tibble")     out  <- gp2tbl(res) %>% tibble::as_tibble()

    out
  }, error = function(e){
    NULL
  })

}
