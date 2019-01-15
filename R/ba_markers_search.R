#' ba_markers_search
#'
#' Search for markers on a brapi server via a GET method.
#'
#' @param con list, brapi connection object
#' @param markerDbIds character vector, search for specific markers by internal
#'                    database identifiers, supplied as a comma separated
#'                    character vector of internal marker database identifiers
#'                    e.g. c("1185","1186"); default: ""
#' @param name character, search for markers by a search pattern of a marker
#'             name or synonym e.g. "11_1002", "11_1%", "11_1*" or "11_10?02";
#'             default: ""
#' @param matchMethod character, search for markers using a match method with as
#'                    possible values "case_insensitive", "exact" (which is case
#'                    sensitive), and "wildcard" (which is case insensitive and
#'                    uses both "*" and "%" for any number of characters and "?"
#'                    for one character matching); default: "", which results in
#'                    "exact"
#' @param includeSynonyms logical, search for markers including synonyms,
#'                        specified as TRUE, or without, specified as FALSE;
#'                        default: NA, possible other values: TRUE/FALSE
#' @param type character, search for a specific type of marker, e.g. "SNP";
#'             default: ""
#' @param pageSize integer, items per page to be returned; default: 1000
#' @param page integer, the requested page to be returned; default: 0 (1st page)
#' @param rclass character, class of the object to be returned; default: "tibble"
#'               , possible other values: "json"/"list"/"vector"/"data.frame"
#'
#' @return An object of class as defined by rclass containing the markers
#'         fulfilling the search criteria.
#'
#' @author Reinhard Simon, Maikel Verouden
#' @references \href{https://github.com/plantbreeding/API/blob/V1.2/Specification/Markers/MarkerSearch_GET.md}{github}
#'
#' @family markers
#' @family genotyping
#'
#' @example inst/examples/ex-ba_markers_search.R
#'
#' @import httr
#' @import progress
#' @export
ba_markers_search <- function(con = NULL,
                              markerDbIds = "",
                              name = "",
                              matchMethod = "",
                              includeSynonyms = NA,
                              type = "",
                              pageSize = 1000,
                              page = 0,
                              rclass = c("tibble", "data.frame",
                                         "list", "json")) {
  ba_check(con = con, verbose = FALSE)
  check_character(markerDbIds, name, matchMethod, type)
  stopifnot(is.logical(includeSynonyms))
  rclass <- match.arg(rclass)

  brp <- get_brapi(con = con) %>% paste0("markers-search")
  callurl <- get_endpoint(pointbase = brp,
                          markerDbIds = markerDbIds,
                          name = name,
                          matchMethod = matchMethod,
                          includeSynonyms = includeSynonyms,
                          type = type,
                          pageSize = pageSize,
                          page = page)

  try({
    resp <- brapiGET(url = callurl, con = con)
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
    class(out) <- c(class(out), "ba_markers_search")
    return(out)
  })
}
