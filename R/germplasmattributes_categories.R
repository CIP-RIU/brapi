#' germplasmattributes_categories
#'
#' attibutes call.
#'
#' @param con brapi connection object
#' @param page integer; default 0
#' @param pageSize integer; default 10
#' @param rclass character; default: tibble
#'
#' @return rclass as set by parameter
#' @import httr
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/GermplasmAttributes/ListAttributeCategories.md}
#' @family germplasmattributes
#' @family genotyping
#' @export
germplasmattributes_categories <- function(con = NULL, page = 0, pageSize = 10, rclass = "tibble"){
  brapi::check(con, FALSE)
  brp <- get_brapi(con)
  attributes_categories_list = paste0(brp, "attributes/categories/")
  if (is.numeric(page) & is.numeric(pageSize)) {
    attributes_categories_list = paste0(attributes_categories_list, "?page=", page, "&pageSize=", pageSize)
  }

  try({
    res <- brapiGET(attributes_categories_list, con = con)
    res <- httr::content(res, "text", encoding = "UTF-8")

    out = dat2tbl(res, rclass)
    class(out) = c(class(out), "brapi_germplasmattributes_categories")
    out
  })
}
