#' ba_genomemaps_data_range
#'
#' Get map data by range on linkageGroup
#'
#' markers ordered by linkageGroup and position

#' @param con brapi connection object
#' @param mapDbId character; default ''
#' @param linkageGroupId character; default NULL
#' @param linkageGroupName character; default ''
#' @param min character; default ''
#' @param max character; default ''
#' @param page integer; default 0
#' @param pageSize character; default 30
#' @param rclass character; default: tibble
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapDataByRangeOnLinkageGroup.md}{github}
#'
#' @family genomemaps
#' @family genotyping
#'
#' @example inst/examples/ex-ba_genomemaps_data_range.R
#'
#' @import tibble
#' @importFrom magrittr '%>%'
#' @export
ba_genomemaps_data_range <- function(con = NULL,
                                     mapDbId = "",
                                     linkageGroupId = NULL,
                                     linkageGroupName = "",
                                     min = 0,
                                     max = 2000,
                                     pageSize = 1000,
                                     page = 0,
                                     rclass = c("tibble", "data.frame",
                                                "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "maps/id/positions/id")
  check_deprecated(linkageGroupId, "linkageGroupName")
  check_character(mapDbId, linkageGroupName)
  stopifnot(is.numeric(min))
  stopifnot(is.numeric(max))
  check_req(mapDbId, linkageGroupName)
  rclass <- match.arg(rclass)

  brp <- get_brapi(con) %>% paste0("maps/", mapDbId, "/positions/", linkageGroupName)
  callurl <- get_endpoint(brp,
                          min = min,
                          max = max,
                          pageSize = pageSize,
                          page = page
                          )

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    if (rclass == "vector") {
      rclass <- "tibble"
    }
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_genomemaps_data_range")

    show_metadata(res)
    return(out)
  })
}
