
#' markers_search
#'
#' Lists markers as result of a search.
#'
#' @param con brapi connection object
#' @param name string; marker name; default: *
#' @param type string; default: all; other: SNP
#' @param matchMethod string; default: wildcard; other: case_insensitive, exact
#' @param include string; default: synonyms
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
#' @family markers
#' @family genotyping
#' @export
markers_search <- function(con = NULL, name = "*",
                             type = "all",
                             matchMethod  = "wildcard",
                             include = "synonyms",
                             page = 0, pageSize = 1000,
                             rclass = "tibble"){
  brapi::check(con, FALSE, "markers")
  brp <- get_brapi(con)
  marker_search <- paste0(brp, "markers/?")

  page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  # name = ifelse(name != "none", paste0("name=", name, "&"), "")
  # type = ifelse(type != "all", paste0("type=", type, "&"), "")
  matchMethod <- ifelse(matchMethod %in% c("exact", "case_insensitive", "wildcard"),
                       paste0("matchMethod=", matchMethod, "&"), "")
  include <- ifelse(include %in% c("synonyms", "none"), paste0("include=", include, "&"), "")
  name <- ifelse(name != "", paste0("name=", name, "&"), "")
  type <- ifelse(type != "", paste0("type=", type, "&"), "")

  rclass <- ifelse(rclass %in% c("tibble", "data.frame", "json", "list"), rclass, "tibble")

  marker_search <- paste0(marker_search, name, type, matchMethod, include,  pageSize, page)
  try({
    res <- brapiGET(marker_search, con = con)
    res <- httr::content(res, "text", encoding = "UTF-8")
    if(rclass %in% c("json", "list")) {
      out <- dat2tbl(res, rclass)
    }
    if(rclass %in% c("data.frame", "tibble")) {
      out <- jsonlite::fromJSON(res, simplifyDataFrame = TRUE, flatten = TRUE)

      meta <- out$metadata
      out <- out$result$data
      attr(out, "metadata") <- meta
      out$synonyms <- sapply(out$synonyms,paste, collapse = "; ")
      out$refAlt <- sapply(out$refAlt,paste, collapse = "; ")
      out$analysisMethods <- sapply(out$analysisMethods, paste, collapse = "; ")
    }
    if(rclass == "tibble") out <- tibble::as_tibble(out)
    class(out) <- c(class(out), "brapi_markers_search")

    out
  })
}

