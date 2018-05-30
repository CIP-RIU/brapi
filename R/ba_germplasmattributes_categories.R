#' ba_germplasmattributes_categories
#'
#' attibutes call.
#'
#' @param con brapi connection object
#' @param page integer; default 0
#' @param pageSize integer; default 10
#' @param rclass character; default: tibble
#'
#' @return rclass as set by parameter
#' @example inst/examples/ex-ba_germplasmattributes_categories.R
#' @import httr
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GermplasmAttributes/ListAttributeCategories.md}{github}
#' @family germplasmattributes
#' @family genotyping
#' @export
ba_germplasmattributes_categories <- function(con = NULL,
                                              page = 0,
                                              pageSize = 10,
                                              rclass = "tibble") {
  ba_check(con = con, verbose = FALSE)
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate the specific brapi call url
  attributes_categories_list <- paste0(brp, "attributes/categories/")
  # modify the specific brapi call url for pagenation
  if (is.numeric(page) & is.numeric(pageSize)) {
      attributes_categories_list <- paste0(
        attributes_categories_list, "?page=", page, "&pageSize=", pageSize)
  }
  try({
    res <- brapiGET(url = attributes_categories_list, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_germplasmattributes_categories")
    show_metadata(res)
    return(out)
  })
}
