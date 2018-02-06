#' ba_calls
#'
#' lists calls available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param datatypes string, list of data types
#' @param con brapi connection object
#' @param pageSize integer; default = 1000
#' @param page integer; default = 0
#'
#' @author Reinhard Simon
#' @example inst/examples/ex_calls.R
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Calls/Calls.md}{github}
#' @return rclass as defined
#' @import tibble
#' @family brapicore
#' @export
ba_calls <- function(con = NULL,
                     datatypes = "all",
                     pageSize = 50,
                     page = 0,
                     rclass = "tibble") {
  # argument checking
  ba_check(con = con, verbose = FALSE, brapi_calls = "calls")
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  stopifnot(datatypes %in% c("all", "json", "csv", "tsv"))
  # obtain the brapi url
  brp <- get_brapi(con = con)
  # generate the call url
  brapi_calls <- paste0(brp, "calls/?")
  pdatatypes <- ifelse(datatypes == "all", "", paste0("datatypes=", datatypes, "&"))
  ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")
  if (pageSize >= 1000) {
    ppage <- ""
    ppageSize <- ""
    datatypes <- ""
    brapi_calls <- paste0(brp, "calls/?")
  }
  # modify the call url with pagenation
  brapi_calls <- paste0(brapi_calls, pdatatypes, ppageSize, ppage)
  try({
    # make the brapi GET call with the generated call url
    res <- brapiGET(url = brapi_calls, con = con)
    out <- NULL
    # parse the GET response
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    if (rclass %in% c("data.frame", "tibble")) {
      out$methods <- sapply(X = out$methods, FUN = paste, collapse = "; ")
      out$datatypes <- sapply(X = out$datatypes, FUN = paste, collapse = "; ")
    }
    class(out) <- c(class(out), "ba_calls")
    return(out)
  })
}
