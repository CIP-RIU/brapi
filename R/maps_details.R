#' maps_details
#'
#' lists maps available on a brapi server
#'
#' @param rclass string; default: tibble
#' @param mapDbId integer; default 0
#'
#' @author Reinhard Simon
#' @references \url{http://docs.brapi.apiary.io/#reference/0/call-search}
#' @return rclass as defined
#' @import tibble
#' @import tidyjson
#' @family brapi_call
#' @family genotyping
#' @export
maps_details <- function(mapDbId = 0, rclass = "tibble") {
  brapi::check(FALSE, "maps/id")
  brp <- get_brapi()
  maps_list = paste0(brp, "maps/", mapDbId, "/")

  try({
    res <- brapiGET(maps_list)
    res <-  httr::content(res, "text", encoding = "UTF-8")
    if(rclass == "vector") rclass = "tibble"
    out = NULL
    if(rclass %in% c("json", "list")) out = dat2tbl(res, rclass)
    if(rclass %in% c("data.frame", "tibble")) {
      lst <- jsonlite::fromJSON(res)
      dat <- jsonlite::toJSON(lst$result$linkageGroups)
      #message(dat)
      if (rclass == 'data.frame') {
        out <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)[[1]]

      } else {
        out <- jsonlite::fromJSON(dat, simplifyDataFrame = TRUE)[[1]] %>% tibble::as_tibble()
      }
      lst$result$linkageGroups <- NULL
      attr(out, "metadata") <- as.list(lst$result)
    }

    out
  })
}
