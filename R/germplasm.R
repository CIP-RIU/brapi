#' germplasm
#'
#' Gets germplasm details given an id.
#'
#' @param germplasmDbId string; default 0; an internal ID for a germplasm
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/germplasm-details-by-germplasmdbid}
#' @return list
#' @export
germplasm <- function(germplasmDbId = 0) {
  brapi::check(FALSE)
  germplasm = paste0(get_brapi(), "germplasm/", germplasmDbId, "/")


  tryCatch({
    res <- httr::GET(germplasm)
    jsonlite::fromJSON(
      httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
                    ), simplifyVector = FALSE
    )
  }, error = function(e){
    NULL
  })

}
