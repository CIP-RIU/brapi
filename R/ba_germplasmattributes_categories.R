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
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/GermplasmAttributes/Attributes_Categories_GET.md}{github}
#'
#' @family germplasmattributes
#' @family genotyping
#'
#' @example inst/examples/ex-ba_germplasmattributes_categories.R
#'
#' @import httr
#' @export
ba_germplasmattributes_categories <- function(con = NULL,
                                              pageSize = 1000,
                                              page = 0,
                                              rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  brp <- get_brapi(con = con) %>% paste0("attributes/categories")
  callurl <- get_endpoint(brp,
                          pageSize = pageSize,
                          page = page
                          )
  rclass <- match_req(rclass)
  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_germplasmattributes_categories")
    show_metadata(res)
    return(out)
  })
}
