
#' germplasm_markerprofiles
#'
#' Gets minimal marker profile data from database using database internal id
#'
#' @param germplasmDbId integer
#' @param format character, default: json; alternative: vector
#' @author Reinhard Simon
#' @return list of marker profile ids
#' @import httr
#' @references \url{http://docs.brapi.apiary.io/#reference/germplasm/markerprofiles/}
#' @export
germplasm_markerprofiles <- function(germplasmDbId = 0, format = "json"){
  brapi::check(FALSE)
  germplasm_markerprofiles = paste0(get_brapi(), "germplasm/", germplasmDbId,
                              "/markerprofiles/")

  out <- tryCatch({
    res <- httr::GET(germplasm_markerprofiles)
    httr::message_for_status(res)
    message("\n")
    jsonlite::fromJSON(
      httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
      ), simplifyVector = FALSE
    )
  }, error = function(e){
    #httr::message_for_status(res)
    NULL
  })

  if(!is.null(out) & format == 'vector'){
    out = out$result$markerProfiles %>% unlist
  }
  out
}
