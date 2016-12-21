
#' germplasm search
#'
#' Lists germplasmm as result of a search.
#'
#' @param germplasmDbId string
#' @param germplasmName string
#' @param germplasmPUI string
#' @param pageSize integer
#' @param page integer
#' @param rclass character; default: tibble
#' @param method string; default 'GET'; alternative 'POST'
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{http://docs.brapi.apiary.io/#reference/0/germplasm-search}
#'
#' @return data.frame
#' @family brapi_call
#' @family core
#' @family germplasm
#' @export
germplasm_search <- function(germplasmDbId = 0,
                             germplasmName = "none",
                             germplasmPUI  = "none",
                             page = 0, pageSize = 1000, method = "GET",
                             rclass = "tibble"){
  brapi::check(FALSE, "germplasm-search")
  brp <- get_brapi()
  if (is.numeric(page) & is.numeric(pageSize)) {
    germplasm_search = paste0(brp, "germplasm-search/?page=", page, "&pageSize=", pageSize)
  }

  if(germplasmName != "none") {
    germplasm_search = paste0(germplasm_search, "&germplasmName=", germplasmName)
  }


  if(germplasmDbId > 0) {
    germplasm_search = paste0(brp, "germplasm-search/?germplasmDbId=", germplasmDbId)
  }


  if(germplasmPUI != "none") {
    germplasm_search = paste0(brp, "germplasm-search/?germplasmPUI=", germplasmPUI)
  }

  if(method == "POST")  { #message_brapi("POST not implemented yet!")
    body = list(germplasmDbId = germplasmDbId,
                germplasmName = germplasmName,
                germplasmPUI  = germplasmPUI,
                page = page,
                pageSize = pageSize)
    out = tryCatch({
      germplasm_search = paste0(brp, "germplasm-search/")
      res <- brapiPOST(germplasm_search, body)
      res <- httr::content(res, "text", encoding = "UTF-8")
      out <- NULL

      if (rclass %in% c("json", "list")) out <- dat2tbl(res, rclass)
      if (rclass == "data.frame") out  <- gp2tbl(res)
      if (rclass == "tibble")     out  <- gp2tbl(res) %>% tibble::as_tibble()

      out
    }, error = function(e){
      NULL
    })

  } else  {

  out = tryCatch({
    res <- brapiGET(germplasm_search)
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

  out

}

