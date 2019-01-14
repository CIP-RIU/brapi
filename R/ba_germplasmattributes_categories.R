#' ba_germplasmattributes_categories
#'
#' Retrieve available germplasm attribute categories.
#'
#' @param con brapi connection object
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"vector"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the available
#'         germplasm attribute categories.
#'
#' @note Tested against: test-server, sweetpotatobsse
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
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
                                              rclass = c("tibble", "data.frame",
                                                          "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  rclass <- match_req(rclass)

  brp <- get_brapi(con = con) %>% paste0("attributes/categories")
  callurl <- get_endpoint(pointbase = brp,
                          pageSize = pageSize,
                          page = page)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = cont, rclass = rclass)
    class(out) <- c(class(out), "ba_germplasmattributes_categories")
    show_metadata(resp)
    return(out)
  })
}
