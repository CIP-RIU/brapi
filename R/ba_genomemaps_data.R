#' ba_genomemaps_data
#'
#' markers ordered by linkageGroup and position
#'
#' @param con brapi connection object
#' @param mapDbId character; default ''
#' @param linkageGroupId character; default: NULL
#' @param linkageGroupName character; default ''
#' @param pageSize integer; default 1000
#' @param page integer; default 0
#' @param rclass character; default: tibble
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapData.md}{github}
#'
#' @family genomemaps
#' @family genotyping
#'
#' @example inst/examples/ex-ba_genomemaps_data.R
#'
#' @import tibble
#' @importFrom magrittr '%>%'
#' @export
ba_genomemaps_data <- function(con = NULL,
                               mapDbId = "",
                               linkageGroupId = NULL,
                               linkageGroupName = "",
                               pageSize = 1000,
                               page = 0,
                               rclass = c("tibble", "data.frame",
                                          "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "maps/id/positions")
  check_deprecated(linkageGroupId, "linkageGroupName")
  check_character(mapDbId, linkageGroupName)
  check_req(linkageGroupId)

  brp <- get_brapi(con = con) %>% paste0("maps/", mapDbId, "/positions")
  callurl <- get_endpoint(brp,
                          linkageGroupName = linkageGroupName,
                          pageSize = pageSize,
                          page = page
                          )


  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")

    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_genomemaps_data")

    show_metadata(res)
    return(out)
  })
}
