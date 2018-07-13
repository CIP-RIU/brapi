#' ba_calls
#'
#' Returns calls available on a brapi server.
#'
#' TODO v1.2: deprecate this and add ba_commonCropNames. The new function won't
#' have datatype parameter.
#'
#' @param con list, brapi connection object
#' @param datatype character, list of data types; default: "csv", other
#'                 possible values: "all"/"json"/"tsv"
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returend; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing all the implemented
#'         BrAPI calls.
#'
#' @note Tested against: sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/tree/master/Specification/Calls}{github}
#' @family brapicore
#' @example inst/examples/ex_calls.R
#' @import tibble
#' @export
ba_calls <- function(con = NULL,
                     datatype = "csv",
                     pageSize = 1000,
                     page = 0,
                     rclass = "tibble") {
  # argument checking
  ba_check(con = con, verbose = FALSE, brapi_calls = "calls")
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  stopifnot(datatype %in% c("all", "json", "csv", "tsv"))
  # obtain the brapi url
  brp <- get_brapi(con = con)
  brapi_calls <- paste0(brp, "calls?")
  pdatatype <- ifelse(datatype == "", "",
                       paste0("datatypes=", datatype, "&"))
  ppage <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                   pageSize, "&"), "")
  if (page == 0 & pageSize == 1000) {
    ppage <- ""
    ppageSize <- ""
  }
  # modify the call url with pagenation
  brapi_calls <- sub("[/?&]$",
                      "",
                      paste0(brapi_calls,
                             pdatatype,
                             ppageSize,
                             ppage))
  try({
    # make the brapi GET call with the generated call url
    res <- brapiGET(url = brapi_calls, con = con)
    out <- NULL
    # parse the GET response
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    if (rclass %in% c("data.frame", "tibble")) {
      out$datatypes <- vapply(X = out$datatypes, FUN = paste, FUN.VALUE = "",
                              collapse = "; ")
      out$methods <- vapply(X = out$methods, FUN = paste, FUN.VALUE = "",
                            collapse = "; ")
      out$versions <- vapply(X = out$versions, FUN = paste, FUN.VALUE = "",
                            collapse = "; ")
      out <- dplyr::select(out, call, datatypes, methods, versions)
    }
    class(out) <- c(class(out), "ba_calls")
    show_metadata(res)
    return(out)
  })
}
