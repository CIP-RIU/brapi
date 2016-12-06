
#' germplasm_pedigree
#'
#' Gets minimal pedigree data from database using database internal id
#'

#' @param germplasmDbId integer; default 0
#' @param notation string; default: purdue format
#'
#' @author Reinhard Simon
#' @return list of pedigree data
#' @import httr
#' @references \url{http://docs.brapi.apiary.io/#reference/germplasm/}
#' @export
germplasm_pedigree <- function(germplasmDbId = 0, notation = "purdue"){
  if(germplasmDbId == 0) return(NULL)
  if(is.null(germplasmDbId)) return(NULL)
  if(is.na(germplasmDbId)) return(NULL)

  germplasm_pedigree = paste0(get_brapi(), "germplasm/", germplasmDbId,
                              "/pedigree/?notation=", notation)

  tryCatch({
    res <- httr::GET(germplasm_pedigree)
    jsonlite::fromJSON(
      httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
      ), simplifyVector = FALSE
    )
  }, error = function(e){
    NULL
  })


}
