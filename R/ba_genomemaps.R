#' ba_genomemaps
#'
#' Get list of maps
#'
#' @note This call must have set a specific identifier. The default is an empty string.
#'      If not changed to an identifier present in the database this will result in an error.
#'
#'
#' @param con brapi connection object
#' @param species character; default:
#' @param type character, default: ''
#' @param pageSize integer; default 1000
#' @param page integer; default 0
#' @param rclass character; default: tibble
#'
#' @return rclass as defined
#'
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/ListOfGenomeMaps.md}{github}
#' @family genomemaps
#' @family genotyping
#'
#' @example inst/examples/ex-ba_genomemaps.R
#'
#' @import tibble
#' @export
ba_genomemaps <- function(con = NULL,
                          species = "",
                          type = "",
                          page = 0,
                          pageSize = 1000,
                          rclass = c("tibble", "data.frame",
                                     "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(species, type)
  rclass <- match.arg(rclass)
  brp <- get_brapi(con = con) %>% paste0("maps")
  callurl <- get_endpoint(brp,
                          species = species,
                          type = type,
                          pageSize = pageSize,
                          page = page
  )

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")

    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_genomemaps")

    show_metadata(res)
    return(out)
  })
}
