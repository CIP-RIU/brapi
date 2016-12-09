#' attributes_categories
#'
#' attibutes call.
#'
#' @param page integer; default 0
#' @param pageSize integer; default 10
#' @param rclass character; default: tibble
#'
#' @return rclass as set by parameter
#' @import httr
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/list-attribute-categories}
#' @export
attributes_categories <- function(page = 0, pageSize = 10, rclass = "tibble"){
  brapi::check(FALSE)
  brp <- get_brapi()

  if (is.numeric(page) & is.numeric(pageSize)) {
    attributes_categories_list = paste0(brp, "attributes/categories/?page=", page, "&pageSize=", pageSize)
  } else {
    attributes_categories_list = paste0(brp, "attributes/categories/")
  }


  tryCatch({
    res <- brapiGET(attributes_categories_list)
    res <- httr::content(res, "text", encoding = "UTF-8")

    dat2tbl(res, rclass)

  }, error = function(e){
    NULL
  })
}
