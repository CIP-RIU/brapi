#' ba_calls
#'
#' Returns calls available on a brapi server.
#'
#' @param con list, brapi connection object
#' @param datatype character, filter implemented brapi calls by supported data
#'                 type, e.g. "csv", "tsv" or "xls"; default: "" for any
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned;  default: "tibble"
#'               , possible other values: "json"/"list"/"data.frame"
#'
#' @return An object of class as defined by rclass containing all the implemented
#'         BrAPI calls.
#'
#' @note Tested against: BMS, sweetpotatobase, test-server
#' @note BrAPI Version: 1.0, 1.1, 1.2
#' @note BrAPI Status: active
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Calls/Calls.md}{github}
#' @family brapicore
#' @example inst/examples/ex_calls.R
#' @import tibble
#' @export
ba_calls <- function(con = NULL,
                     datatype = c("", "csv", "tsv", "json", "xls", "xlsx"),
                     pageSize = 1000,
                     page = 0,
                     rclass = c("tibble", "data.frame", "list", "json")) {

  ba_check(con = con, verbose = FALSE, brapi_calls = "calls")
  datatype <- match.arg(datatype)
  rclass <- match.arg(rclass)

  # temporarily store the multicrop argument in omc (oldmulticrop)
  omc <- con$multicrop
  con$multicrop <- FALSE

  brp <- get_brapi(con = con) %>% paste0("calls")
  callurl <- get_endpoint(brp,
                          datatype = datatype,
                          pageSize = pageSize,
                          page = page)

  try({
    # make the brapi GET call with the generated call url
    res <- brapiGET(url = callurl, con = con)

    # parse the GET response
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res2, rclass = rclass)
    if (rclass %in% c("data.frame", "tibble")) {
      out$datatypes <- vapply(X = out$datatypes, FUN = paste, FUN.VALUE = "",
                              collapse = "; ")
      out$methods <- vapply(X = out$methods, FUN = paste, FUN.VALUE = "",
                            collapse = "; ")
      if(!is.null(out$versions)) {
        out$versions <- vapply(X = out$versions, FUN = paste, FUN.VALUE = "",
                               collapse = "; ")
      }

    }
    class(out) <- c(class(out), "ba_calls")
    show_metadata(res)
    # reset multicrop argument in con object to omc (oldmulticrop) value
    con$multicrop <- omc
    return(out)
  })
}
