#' ba_programs_search
#'
#' searches the breeding programs
#'
#'
#' @param con list, brapi connection object
#'
#' @param abbreviation character; default: ''
#' @param leadPerson character; default: ''
#' @param name character; default: ''
#' @param objective character; default: ''
#' @param page integer; default: 0
#' @param pageSize integer, default: 1000
#' @param programDbId character; default: ''
#'
#' @param rclass character; default: tibble
#'
#' @import httr
#' @author Reinhard Simon
#' @return rclass
#' @example inst/examples/ex-ba_programs_search.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Programs/ProgramSearch.md}{github}
#' @family brapicore
#' @export
ba_programs_search <- function(con = NULL,
                               abbreviation = "",
                               leadPerson = "",
                               name = "",
                               objective = "",
                               page = 0,
                               pageSize = 1000,
                               programDbId = "",
                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "programs-search")
  stopifnot(is.character(programDbId))
  stopifnot(is.character(name))
  stopifnot(is.character(abbreviation))
  stopifnot(is.character(objective))
  stopifnot(is.character(leadPerson))

  check_paging(pageSize, page)
  check_rclass(rclass)
  # fetch url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate specific brapi call url
  pprograms <- paste0(brp, "programs-search/")
  try({
    body <- list(abbreviation =
                   ifelse(abbreviation != '',
                          abbreviation,
                          ''),
                 leadPerson =
                   ifelse(leadPerson != '',
                          leadPerson,
                          ''),
                 name =
                   ifelse(name != '',
                          name,
                          ''),
                 objective =
                   ifelse(objective != '',
                          objective,
                          ''),
                 pageSize =
                   ifelse(pageSize != '',
                          pageSize %>%
                            as.integer(),
                          ''),
                 page =
                   ifelse(page != '',
                          page %>%
                            as.integer(),
                          '')
    )
    for (i in length(body):1) {
      if(body[[i]] == '') {
        body[[i]] <- NULL
      }
    }
    message("Query params:")
    message(str(body))



    res <- brapiPOST(url = pprograms, body = body, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_programs_search")
    show_metadata(res)
    return(out)
  })
}
