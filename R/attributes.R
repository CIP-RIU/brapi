#' attributes
#'
#' attibutes call.
#'
#' @param attributeCategoryDbId integer; default: 0
#' @param rclass character; default: tibble
#'
#' @return rclass as set by parameter
#' @import httr
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/list-attributes-available/attributes-by-attributecategorydbid}
#' @family brapi_call
#' @family genotyping
#' @family attributes
#' @export
attributes <- function(attributeCategoryDbId = 0, rclass = "tibble"){
  brapi::check(FALSE)
  brp <- get_brapi()
  attributes_list = paste0(brp, "attributes/?attributeCategoryDbId=", attributeCategoryDbId)


  tryCatch({
    res <- brapiGET(attributes_list)
    res <- httr::content(res, "text", encoding = "UTF-8")

    out <- dat2tbl(res, rclass)
    if (rclass %in% c("tibble", "data.frame")){
      out$values <- sapply(out$values, paste, collapse = "; ")
    }
    out
  }, error = function(e){
    NULL
  })
}
