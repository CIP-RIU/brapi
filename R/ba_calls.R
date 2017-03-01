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
ba_calls <- function(con = NULL, datatypes = "all",
                  pageSize = 50, page = 0, rclass = "tibble") {
    ba_check(con, FALSE, "calls")
    brp <- get_brapi(con)
    brapi_calls <- paste0(brp, "calls/?")
    pdatatypes <- ifelse(datatypes == "all", "", paste0("datatypes=",
                                                        datatypes, "&"))
    ppage <- ifelse(is.numeric(page), paste0("page=", page, ""), "")
    ppageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                     pageSize, "&"), "")
    if (pageSize >= 1000){
      ppage <- ""
      ppageSize <- ""
      datatypes <- ""
      brapi_calls <- paste0(brp, "calls/?")
    }
    brapi_calls <- paste0(brapi_calls, pdatatypes, ppageSize, ppage)
    try({
        res <- brapiGET(brapi_calls, con = con)
        out <- NULL
        res <- httr::content(res, "text", encoding = "UTF-8")
        out <- dat2tbl(res, rclass)

        if (rclass %in% c("data.frame", "tibble")) {
            out$methods <- sapply(out$methods, paste, collapse = "; ")
            out$datatypes <- sapply(out$datatypes, paste, collapse = "; ")
        }
        class(out) <- c(class(out), "ba_calls")
        return(out)
    })
}