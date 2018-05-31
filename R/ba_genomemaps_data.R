#' ba_genomemaps_data
#'
#' markers ordered by linkageGroup and position
#'
#' @param con brapi connection object
#' @param rclass character; default: tibble
#' @param page integer; default 0
#' @param pageSize integer; default 30
#' @param mapDbId character; default ''
#' @param linkageGroupName character; default ''
#' @example inst/examples/ex-ba_genomemaps_data.R
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapData.md}{github}
#' @return rclass as defined
#' @import tibble
#' @importFrom magrittr '%>%'
#' @family genomemaps
#' @family genotyping
#' @export
ba_genomemaps_data <- function(con = NULL,
                               mapDbId = "",
                               linkageGroupName = "",
                               page = 0,
                               pageSize = 30,
                               rclass = "tibble") {
  ba_check(con = con, verbose = FALSE, brapi_calls = "maps/id/positions")
  stopifnot(is.character(mapDbId))
  stopifnot(is.character(linkageGroupName))
  check_paging(pageSize = pageSize, page = page)
  check_rclass(rclass = rclass)
  # fetch the url of the brapi implementation of the database
  brp <- get_brapi(con = con)
  # generate the call url
  maps_positions_list <- paste0(brp, "maps/", mapDbId, "/positions/?")
  linkageGroupName <- ifelse(linkageGroupName != '',
                             paste("linkageGroupName=", linkageGroupName, "&", sep = "") %>%
                      paste(collapse = ""),
                      '')
  page <- ifelse(is.numeric(page), paste0("page=", page, "&"), "")
  pageSize <- ifelse(is.numeric(pageSize), paste0("pageSize=",
                                                  pageSize, "&"), "")
  # modify the call url to include pagenation and linkageGroupName
  maps_positions_list <- paste0(maps_positions_list,
                                page, pageSize, linkageGroupName)
  try({
    res <- brapiGET(url = maps_positions_list, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")
    if (rclass == "vector") {
      rclass <- "tibble"
    }
    out <- dat2tbl(res = res2, rclass = rclass)
    class(out) <- c(class(out), "ba_genomemaps_data")

    show_metadata(res)
    return(out)
  })
}
