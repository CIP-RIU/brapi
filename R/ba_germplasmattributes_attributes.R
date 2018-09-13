#' ba_germplasmattributes_attributes
#'
#' List supported crops in a database.
#'
#' @param con list, brapi connection object
#' @param attributeCategoryDbId character, optional, default: ''
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"vector"/"data.frame"
#'
#' @return as defined by rclass
#'
#' @note Tested against: test-server, sweetpotatobsse
#' @note BrAPI Version: 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/GermplasmAttributes/Attributes_GET.md}{github}
#' @family brapicore
#' @family germplasmattributes
#' @example inst/examples/ex-ba_germplasmattributes_attributes.R
#' @export
ba_germplasmattributes_attributes <- function(con = NULL,
                               attributeCategoryDbId = "",
                               pageSize = 1000,
                               page = 0,
                               rclass = c("tibble", "data.frame", "list", "json")) {
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
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)

    class(out) <- c(class(out), "ba_crops")
    out
  })

  return(out)
}
