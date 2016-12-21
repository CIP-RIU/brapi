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
#' @family brapi_call
#' @family genotyping
#' @family attributes
#' @export
attributes_categories <- function(page = 0, pageSize = 10, rclass = "tibble"){
  brapi::check(FALSE)
  brp <- get_brapi()
  attributes_categories_list = paste0(brp, "attributes/categories/")
  if (is.numeric(page) & is.numeric(pageSize)) {
    attributes_categories_list = paste0(attributes_categories_list, "?page=", page, "&pageSize=", pageSize)
  }

  try({
    res <- brapiGET(attributes_categories_list)
    res <- httr::content(res, "text", encoding = "UTF-8")

    dat2tbl(res, rclass)

  })
}
