
#' germplasm search
#'
#' Lists germplasmm as result of a search.
#'
#' @param germplasmDbId string
#' @param germplasmName string
#' @param germplasmPUI string
#' @param pageSize integer
#' @param page integer
#' @param method string; default 'GET'; alternative 'POST'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{http://docs.brapi.apiary.io/reference/germplasm/germplasm-search/search-names-to-retrieve-germplasm-records}
#'
#' @return data.frame
#' @export
germplasm_search <- function(germplasmDbId = 0,
                             germplasmName = "none",
                             germplasmPUI  = "none",
                             page = 0, pageSize = 1000, method = "GET"){
  brapi::check(FALSE)
  if (is.numeric(page) & is.numeric(pageSize)) {
    germplasm_search = paste0(get_brapi(), "germplasm-search/?page=", page, "&pageSize=", pageSize)
  }

  if(germplasmName != "none") {
    germplasm_search = paste0(germplasm_search, "&germplasmName=", germplasmName)
  }


  if(germplasmDbId > 0) {
    germplasm_search = paste0(get_brapi(), "germplasm-search/?germplasmDbId=", germplasmDbId)
  }


  if(germplasmPUI != "none") {
    germplasm_search = paste0(get_brapi(), "germplasm-search/?germplasmPUI=", germplasmPUI)
  }

  if(method == "POST")  message("POST not implemented yet!")

  germplasm_search <- tryCatch({
    #res <- ifelse(method == 'GET', httr::GET(germplasm_search), httr::GET(germplasm_search))
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

