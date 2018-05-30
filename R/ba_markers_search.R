#' ba_markers_search
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param name character; marker name; default: *
#' @param type character; default: all; other: SNP
#' @param matchMethod character; default: wildcard; other: case_insensitive, exact
#' @param include character; default: synonyms
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/Markers/MarkerSearch.md}{github}
#'
#' @return data.frame
#' @example inst/examples/ex-ba_markers_search.R
#' @family markers
#' @family genotyping
#' @export
ba_markers_search <- function(con = NULL,
                              name = "*",
                              type = "all",
                              matchMethod = "wildcard",
                              include = "synonyms",
                              page = 0,
                              pageSize = 1000,
                              rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "markers")
  stopifnot(is.character(name))
  stopifnot(is.character(type))
  stopifnot(matchMethod %in% c("wildcard", "case_insensitive", "exact"))
  stopifnot(include == "synonyms")
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  brp <- get_brapi(con = con)
  marker_search <- paste0(brp, "markers/?")
  page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                  pageSize, "&"), "")
  matchMethod <- ifelse(matchMethod %in%
                      c("exact", "case_insensitive", "wildcard"),
                      paste0("matchMethod=", matchMethod, "&"), "")
  include <- ifelse(include %in% c("synonyms", "none"), paste0("include=",
                                                        include, "&"), "")
  name <- ifelse(name != "", paste0("name=", name, "&"), "")
  type <- ifelse(type != "", paste0("type=", type, "&"), "")
  rclass <- ifelse(rclass %in% c("tibble", "data.frame", "json", "list"),
                   rclass, "tibble")
  marker_search <- paste0(marker_search, name, type, matchMethod,
                          include, pageSize, page)
  try({
    res <- brapiGET(url = marker_search, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = res2, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- jsonlite::fromJSON(txt = res2, simplifyDataFrame = TRUE,
                                flatten = TRUE)
      meta <- out$metadata
      out <- out$result$data
      attr(out, "metadata") <- meta
      out$synonyms <- sapply(X = out$synonyms, FUN = paste, collapse = "; ")
      out$refAlt <- sapply(X = out$refAlt, FUN = paste, collapse = "; ")
      out$analysisMethods <- sapply(X = out$analysisMethods,
                                    FUN = paste, collapse = "; ")
    }
    if (rclass == "tibble") {
      out <- tibble::as_tibble(out)
    }
    show_metadata(res)
    class(out) <- c(class(out), "ba_markers_search")
    return(out)
  })
}
