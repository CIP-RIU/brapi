#' ba_genomemaps_details
#'
#' lists genomemaps_details available on a brapi server
#'
#' @param con brapi connection object
#' @param mapDbId character; default ''
#' @param pageSize integer; default 1000
#' @param page integer; default 0
#' @param rclass character; default: tibble
#'
#' @return rclass as defined
#'
#' @author Reinhard Simon
#' @references \href{https://github.com/plantbreeding/API/blob/master/Specification/GenomeMaps/GenomeMapDetails.md}{github}
#' @family genomemaps
#' @family genotyping
#'
#' @example inst/examples/ex-genomemaps_details.R
#'
#' @import tibble
#' @export
ba_genomemaps_details <- function(con = NULL,
                                  mapDbId = "",
                                  page = 0,
                                  pageSize = 1000,
                                  rclass = c("tibble", "data.frame",
                                             "list", "json")) {
  ba_check(con = con, verbose = FALSE, brapi_calls = "maps/id")
  check_character(mapDbId)
  check_req(mapDbId)
  rclass <- match.arg(rclass)
  brp <- get_brapi(con = con) %>% paste0("maps/", mapDbId)
  callurl <- get_endpoint(brp,
                          pageSize = pageSize,
                          page = page
  )

  try({
    res <- brapiGET(url = callurl, con = con)
    res2 <- httr::content(x = res, as = "text", encoding = "UTF-8")

    out <- NULL
    if (rclass %in% c("json", "list")) {
      out <- dat2tbl(res2, rclass)
    }
    if (rclass %in% c("data.frame", "tibble")) {
      lst <- jsonlite::fromJSON(txt = res2)
      dat <- jsonlite::toJSON(x = lst$result$linkageGroups)
      if (rclass == "data.frame") {
        out <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE)
        out <- out[[1]] %>% tibble::as_tibble() %>% as.data.frame()
      } else {
        out <- jsonlite::fromJSON(txt = dat, simplifyDataFrame = TRUE)  #%>%

        out <- tibble::as_tibble(out)
      }
      if (!is.null(lst$result$linkageGroups)) {
        lst$result$linkageGroups <- NULL
      }
      attr(out, "metadata") <- as.list(lst$result)
    }
    class(out) <- c(class(out), "ba_genomemaps_details")

    show_metadata(res)
    return(out)
  })
}
