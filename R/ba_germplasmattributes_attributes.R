#' ba_germplasmattributes_attributes
#'
#' Retrieve available attributes.
#'
#' @param con brapi connection object
#' @param attributeCategoryDbId character, filter for kind of attribute by
#'                              supplying an internal attribute category database
#'                              identifier e.g. "2"; default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"vector"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the available
#'         attributes.
#'
#' @note Tested against: test-server, sweetpotatobsse
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/GermplasmAttributes/Attributes_GET.md}{github}
#'
#' @family germplasmattributes
#' @family genotyping
#'
#' @example inst/examples/ex-ba_germplasmattributes_attributes.R
#'
#' @export
ba_germplasmattributes_attributes <- function(con = NULL,
                                              attributeCategoryDbId = "",
                                              pageSize = 1000,
                                              page = 0,
                                              rclass = c("tibble", "data.frame",
                                                         "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(attributeCategoryDbId)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("/attributes")
  callurl <- get_endpoint(brp,
                          attributeCategoryDbId = attributeCategoryDbId,
                          pageSize = pageSize,
                          page = page
                          )

  out <- try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = cont, rclass = rclass)

    class(out) <- c(class(out), "ba_germplasmattributes_attributes")
    show_metadata(resp)
    out
  })

  return(out)
}
