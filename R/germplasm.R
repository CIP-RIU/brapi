#' germplasm
#'
#' Gets germplasm details given an id.
#'
#' @param germplasmDbId string; default NULL; an internal ID for a germplasm
#' @author Reinhard Simon
#' @return list
#' @export
germplasm <- function(germplasmDbId = NULL) {
  if(is.null(germplasmDbId)) return(NULL)
  if(is.na(germplasmDbId)) return(NULL)
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
