
#' germplasm search
#'
#' Lists germplasmm as result of a search.
#'
#' @param germplasmDbId string
#' @param germplasmName string
#' @param germplasmPUI string
#' @param pageSize integer
#' @param page integer
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{http://docs.brapi.apiary.io/reference/germplasm/germplasm-search/search-names-to-retrieve-germplasm-records}
#'
#' @return data.frame
#' @export
germplasm_search <- function(germplasmDbId = "none",
                             germplasmName = "none",
                             germplasmPUI  = "none",
                             page = 0, pageSize = 10){
  if(page == 0 & pageSize == 100) {
    germplasm_search = paste0(get_brapi(), "germplasm-search")
  } else if (is.numeric(page) & is.numeric(pageSize)) {
    germplasm_search = paste0(get_brapi(), "germplasm-search/?page=", page, "&pageSize=", pageSize)
  }

  if(germplasmDbId != "none") {
    germplasm_search = paste0(get_brapi(), "germplasm-search/?germplasmDbId=", germplasmDbId)
  }

  if(germplasmName != "none") {
    germplasm_search = paste0(get_brapi(), "germplasm-search/?germplasmName=", germplasmName)
  }

  if(germplasmPUI != "none") {
    germplasm_search = paste0(get_brapi(), "germplasm-search/?germplasmPUI=", germplasmPUI)
  }

  germplasm_search <- tryCatch({
    res <- httr::GET(germplasm_search)
    jsonlite::fromJSON(
      httr::content(res, "text",
                    encoding = "UTF-8" # This removes a message
      ), simplifyVector = FALSE
    )
  }, error = function(e){
    NULL
  })

  germplasm_search
}

