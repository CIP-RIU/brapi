
#' marker search
#'
#' Lists markers as result of a search.
#'
#' @param name string; marker name; default: none
#' @param type string; default: all; other: SNP
#' @param matchMethod string; default: exact; other: case_insensitive, wildcard
#' @param include string; default: synonyms
#' @param page integer; default: 0
#' @param pageSize integer; default 1000
#' @param rclass character; default: tibble
#'
#' @author Reinhard Simon
#' @import httr
#' @import progress
#' @importFrom magrittr '%>%'
#' @references \url{http://docs.brapi.apiary.io/#reference/0/germplasm-search}
#'
#' @return data.frame
#' @family brapi_call
#' @family core
#' @family germplasm
#' @export
marker_search <- function(name = "none",
                             type = "all",
                             matchMethod  = "exact",
                             include = "synonyms",
                             page = 0, pageSize = 1000,
                             rclass = "tibble"){
  brapi::check(FALSE, "markers")
  brp <- get_brapi()
  marker_search = paste0(brp, "markers/?")

  page = ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize = ifelse(is.numeric(pageSize), paste0("pageSize=", pageSize, "&"), "")

  name = ifelse(name != "none", paste0("name=", name, "&"), "")
  type = ifelse(type != "all", paste0("type=", type, "&"), "")
  matchMethod = ifelse(matchMethod %in% c("exact", "case_insensitive", "wildcard"),
                       paste0("matchMethod=", matchMethod, "&"), "")
  include = ifelse(include %in% c("synonyms", "none"), paste0("include=", include, "&"), "")
  rclass = ifelse(rclass %in% c("tibble", "data.frame", "json", "list"), rclass, "tibble")

  marker_search = paste0(marker_search, name, type, matchMethod, include,  pageSize, page)

  try({
    res <- brapiGET(marker_search)
    res <- httr::content(res, "text", encoding = "UTF-8")
    # out <- NULL
    #
    # if (rclass %in% c("json", "list")) out <- dat2tbl(res, rclass)
    # if (rclass == "data.frame") out  <- mk2tbl(res, include)
    # if (rclass == "tibble")     out  <- mk2tbl(res, include) %>% tibble::as_tibble()
    #
    # out
    #
    dat2tbl(res, rclass)
  })
}

