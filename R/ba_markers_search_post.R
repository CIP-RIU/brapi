#' ba_markers_search_post
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param markerDbIds character, optional, default: ''
#' @param name character; marker name; default: ''
#' @param matchMethod character; default: ''; other: case_insensitive, exact, wildcard
#' @param includeSynonyms logical, default: TRUE
#' @param type character; default: all; other: SNP
#' @param pageSize integer; default 1000
#' @param page integer; default: 0
#' @param rclass character; default: tibble
#'
#' @return rclass as requested
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Markers/MarkerSearch_POST.md}{github}
#'
#' @family markers
#' @family genotyping
#'
#' @example inst/examples/ex-ba_markers_search_post.R
#'
#' @import httr
#' @import progress
#' @export
ba_markers_search_post <- function(con = NULL,
                              markerDbIds = '',
                              name = "",
                              matchMethod = "",
                              includeSynonyms = TRUE,
                              type = "",
                              pageSize = 1000,
                              page = 0,
                              rclass = c("tibble", "data.frame",
                                         "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(markerDbIds, name, matchMethod, type)
  stopifnot(is.logical(includeSynonyms))
  rclass <- match.arg(rclass)

  callurl <- get_brapi(con = con) %>% paste0("markers-search")
  body <- get_body(markerDbIds = markerDbIds,
                  name = name,
                  matchMethod = matchMethod,
                  includeSynonyms = includeSynonyms,
                  type = type,
                  pageSize = pageSize,
                  page = page
                  )

  try({
    resp <- brapiPOST(url = callurl, body = body, con = con)
    cont <- httr::content(x = resp, as = "text", encoding = "UTF-8")
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res = cont, rclass = rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      out <- jsonlite::fromJSON(txt = cont, simplifyDataFrame = TRUE,
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
    show_metadata(resp)
    class(out) <- c(class(out), "ba_markers_search_post")
    return(out)
  })
}
