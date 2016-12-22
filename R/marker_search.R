
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
  brapi::check(FALSE)
  brp <- get_brapi()
  if (is.numeric(page) & is.numeric(pageSize)) {
    marker_search = paste0(brp, "markers/?page=", page, "&pageSize=", pageSize)
  }
  marker_search = paste0(marker_search, "&matchMethod=", matchMethod)

  if(include != "none") marker_search = paste0(marker_search, "&include=synonyms")
  if(name != "none") marker_search = paste0(marker_search, "&name=", name)
  if(type != "all")  marker_search = paste0(marker_search, "&type=", type)

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

