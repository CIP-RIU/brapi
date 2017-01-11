#' trials
#'
#' lists trials available on a brapi server
#'
#' @param con brapi connection object
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
#' @references \url{https://github.com/plantbreeding/API/blob/master/Specification/Trials/ListTrialSummaries.md}(github)
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family trials
#' @family phenotyping
#' @export
trials <- function(con = NULL, programDbId = "any", locationDbId = "any", active = "any",
                      sortBy = "none", sortOrder = "asc",
                      page = 0, pageSize = 1000, rclass = "tibble") {
  brapi::check(con, FALSE, "trials")
  brp <- get_brapi(con)
  ptrials = paste0(brp, "trials/?")


  programDbId = paste0("programDbId=", programDbId, "&")
  locationDbId = paste0("locationDbId=", locationDbId, "&")
  active = paste0("active=", active, "&")
  sortBy = paste0("sortBy=", sortBy, "&")
  sortOrder = paste0("sortOrder=", sortOrder, "&")

  page = ifelse(is.numeric(page), paste0("page=", page, ""), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  ptrials = paste0(ptrials, programDbId, locationDbId, active, sortBy, sortOrder, pageSize, page)


  try({
    res <- brapiGET(ptrials, con = con)
    res <- httr::content(res, "text", encoding = "UTF-8")
    out = NULL
    if(rclass %in% c("list", "json")) out = dat2tbl(res, rclass)
    if(rclass %in% c("data.frame", "tibble")) out = trl2tbl(res, rclass)
    class(out) = c(class(out), "brapi_trials")
    out
  })
}
