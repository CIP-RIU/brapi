#' ba_programs_search
#'
#' searches the breeding programs
#'
#'
#' @param con list, brapi connection object
#' @param rclass character; default: tibble
#' @param name character; default: any
#' @param abbreviation character; default: any
#' @param programDbId character; default: any
#' @param objective character; default: any
#' @param leadPerson character; default: any
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @example inst/examples/ex-ba_programs_search.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Programs/ProgramSearch.md}{github}
#' @family brapicore
#' @export
ba_programs_search <- function(con = NULL,
                               programDbId = "any",
                               name = "any",
                               abbreviation = "any",
                               objective = "any",
                               leadPerson = "any",
                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "programs-search")
  stopifnot(is.character(programDbId))
  stopifnot(is.character(name))
  stopifnot(is.character(abbreviation))
  stopifnot(is.character(objective))
  stopifnot(is.character(leadPerson))
  check_rclass(rclass)
  # fetch url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate specific brapi call url
  pprograms <- paste0(brp, "programs-search/")
  try({
    body <- list(programDbId = programDbId,
                 name = name,
                 abbreviation = abbreviation,
                 objective = objective,
                 leadPerson = leadPerson)
    res <- brapiPOST(url = pprograms, body = body, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    class(out) <- c(class(out), "ba_programs_search")
    show_metadata(con, res)
    return(out)
  })
}
