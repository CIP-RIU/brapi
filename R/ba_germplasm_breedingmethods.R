#' ba_germplasm_breedingmethods
#'
#' Lists breeding methods available on a brapi server.
#'
#' @param con list, brapi connection object
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing breedingmethods.
#'
#' @note Tested against: test-server
#' @note BrAPI Version: 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Germplasm/BreedingMethods_GET.md}{github}
#' @family germplasm
#'
#' @example inst/examples/ex-ba_germplasm_breedingmethods.R
#'
#' @import tibble
#' @export
ba_germplasm_breedingmethods <- function(con = NULL,
                         pageSize = 1000,
                         page = 0,
                         rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "breedingmethods")
  rclass <- match.arg(rclass)

  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con) %>% paste0("breedingmethods")
  callurl <- get_endpoint(brp, pageSize = pageSize, page = page)

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("tibble", "data.frame")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (!is.null(out)) {
      class(out) <- c(class(out), "ba_germplasm_breedingmethods")
    }
    show_metadata(res)
    return(out)
  })
}
