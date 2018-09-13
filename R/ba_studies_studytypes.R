#' ba_studies_studytypes
#'
#' Retrieve study types available on a BrAPI compliant database server.
#'
#' @param con list, brapi connection object
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned; default:
#'               "tibble", possible other values: "data.frame"/"list"/"json"
#'
#' @return An object of class as defined by rclass containing the study types on
#'         the BrAPI compliant database server.
#'
#' @note Tested against: test-server, sweetpotatobase
#' @note BrAPI Version: 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/StudyTypes_GET.md}{github}
#'
#' @family studies
#' @family phenotyping
#'
#' @example inst/examples/ex-ba_studies_studytypes.R
#' @import tibble
#' @export
ba_studies_studytypes <- function(con = NULL,
                                  page = 0,
                                  pageSize = 1000,
                                  rclass = c("tibble", "data.frame", "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "studytypes")
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("studytypes")
  callurl <- get_endpoint(pointbase = brp, pageSize = pageSize, page = page)

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = res, as = "text", encoding = "UTF-8")

    out <- dat2tbl(res = cont, rclass = rclass)
    class(out) <- c(class(out), "ba_studies_studytypes")
    show_metadata(resp)
    return(out)
  })
}
