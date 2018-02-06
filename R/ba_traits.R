#' ba_traits
#'
#' lists brapi_traits available on a brapi server
#'
#' @param rclass character; default: tibble
#' @param con list; brapi connection object
#' @param page integer; default 0
#' @param pageSize integer; defautlt 1000
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Traits/ListAllTraits.md}{github}
#' @author Reinhard Simon
#' @return rclass as defined
#' @example inst/examples/ex-ba_traits.R
#' @import tibble
#' @family traits
#' @family brapicore
#' @export
ba_traits <- function(con = NULL,
                      page = 0,
                      pageSize = 1000,
                      rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "traits")
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  traits <- paste0(brp, "traits/?")
  ppage <- paste0("page=", page, "")
  ppageSize <- paste0("pageSize=", pageSize, "&")
  traits <- paste0(traits, ppageSize, ppage)
  try({
    res <- brapiGET(url = traits, con = con)
    res <- httr::content(x = res, as = "text", encoding = "UTF-8")
    out <- dat2tbl(res = res, rclass = rclass)
    if (rclass %in% c("data.frame", "tibble")) {
      if ("observationVariables" %in% colnames(out)) {
        out$observationVariables <- sapply(X = out$observationVariables, FUN = paste, collapse = "; ")
      }
    }
    class(out) <- c(class(out), "ba_traits")
    show_metadata(con, res)
    return(out)
  })
}
