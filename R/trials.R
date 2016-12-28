#' trials
#'
#' lists trials available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 1000
#' @param programDbId character; default: 'any'; otherwise an identifier
#' @param locationDbId character; default: 'any'; otherwise an identifier
#' @param active character; default: 'any'; otherwise TRUE or FALSE
#' @param sortBy character; default: 'none'; otherwise a name from the first level entry names of the return object.
#' @param sortOrder character; default: 'asc'; otherwise 'desc'
#'
#' @author Reinhard Simon
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Trials/ListTrialSummaries.md}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family phenotyping
#' @export
trials <- function(programDbId = "any", locationDbId = "any", active = "any",
                      sortBy = "none", sortOrder = "asc",
                      page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(FALSE, "trials")
  brp <- get_brapi()
  ptrials = paste0(brp, "trials/?")


  page = ifelse(is.numeric(page), paste0("page=", page, ""), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  ptrials = paste0(ptrials,  pageSize, page)


  try({
    res <- brapiGET(ptrials)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out = dat2tbl(res, rclass)

    out
  })
}
