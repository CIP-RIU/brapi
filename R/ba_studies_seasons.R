#' ba_studies_seasons
#'
#' Retrieve all seasons (or years) on a brapi server.
#'
#' @param con list, brapi connection object
#' @param year integer, filter by specified year; default: 0
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing all seasons (or
#'         years).
#'
#' @note Tested against: sweetpotato, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Studies/Seasons_GET.md}{github}
#' @family studies
#' @family phenotyping
#' @example inst/examples/ex-ba_studies_seasons.R
#' @import httr
#' @export
ba_studies_seasons <- function(con = NULL,
                               year = 0,
                               pageSize = 1000,
                               page = 0,
                               rclass = c("tibble", "data.frame",
                                          "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  stopifnot(is.numeric(year))
  rclass <- match.arg(rclass)

  brp <- get_brapi(con) %>% paste0("seasons")
  callurl <- get_endpoint(brp,
                          year = year,
                          pageSize = pageSize,
                          page = page
                          )

  try({
    resp <- brapiGET(url = callurl, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = cont, rclass = rclass)
    class(out) <- c(class(out), "ba_studies_seasons")
    show_metadata(resp)
    return(out)
  })
}
